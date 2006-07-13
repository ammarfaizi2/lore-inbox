Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWGMSaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWGMSaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWGMSaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:30:16 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:11212 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030277AbWGMSaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:30:13 -0400
Subject: Re: [PATCH -mm 5/7] add user namespace
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
In-Reply-To: <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
References: <20060711075051.382004000@localhost.localdomain>
	 <20060711075420.937831000@localhost.localdomain>
	 <m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com> <44B50088.1010103@fr.ibm.com>
	 <m1psgaag7y.fsf@ebiederm.dsl.xmission.com> <44B684A5.2040008@fr.ibm.com>
	 <20060713174721.GA21399@sergelap.austin.ibm.com>
	 <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 11:29:50 -0700
Message-Id: <1152815391.7650.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 12:14 -0600, Eric W. Biederman wrote:
> Maybe.  I really think the sane semantics are in a different uid namespace.
> So you can't assumes uids are the same.  Otherwise you can't handle open
> file descriptors or files passed through unix domain sockets.

Eric, could you explain this a little bit more?  I'm not sure I
understand the details of why this is a problem?

-- Dave

