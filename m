Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161111AbWGNO2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbWGNO2P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 10:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWGNO2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 10:28:15 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:37779 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161109AbWGNO2O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 10:28:14 -0400
Subject: Re: [PATCH -mm 5/7] add user namespace
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
In-Reply-To: <m17j2gzw5u.fsf@ebiederm.dsl.xmission.com>
References: <20060711075051.382004000@localhost.localdomain>
	 <20060711075420.937831000@localhost.localdomain>
	 <m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com> <44B50088.1010103@fr.ibm.com>
	 <m1psgaag7y.fsf@ebiederm.dsl.xmission.com> <44B684A5.2040008@fr.ibm.com>
	 <20060713174721.GA21399@sergelap.austin.ibm.com>
	 <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	 <1152815391.7650.58.camel@localhost.localdomain>
	 <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	 <1152821011.24925.7.camel@localhost.localdomain>
	 <m17j2gzw5u.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 07:28:06 -0700
Message-Id: <1152887287.24925.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 21:45 -0600, Eric W. Biederman wrote:
> I think for filesystems like /proc and /sys that there will normally
> be problems.  However many of those problems can be rationalized away
> as a reasonable optimization, or are not immediately apparent.

Could you talk about some of these problems?

> Passing a file descriptor between process in a unix domain socket is
> a case where I can easily construct scenarios where there are
> indisputable problems.  It is one of my standard thought experiments
> to see if a namespace is sound.

Care to share some of those indisputable problems?

-- Dave

