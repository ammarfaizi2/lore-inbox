Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWGNRYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWGNRYN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWGNRYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:24:13 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:2795 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030214AbWGNRYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:24:13 -0400
Subject: Re: [PATCH -mm 5/7] add user namespace
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
In-Reply-To: <m1mzbct895.fsf@ebiederm.dsl.xmission.com>
References: <m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
	 <44B684A5.2040008@fr.ibm.com>
	 <20060713174721.GA21399@sergelap.austin.ibm.com>
	 <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	 <1152815391.7650.58.camel@localhost.localdomain>
	 <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	 <20060713214101.GB2169@sergelap.austin.ibm.com>
	 <m1y7uwyh9z.fsf@ebiederm.dsl.xmission.com>
	 <20060714140237.GD28436@sergelap.austin.ibm.com>
	 <m1k66gw88t.fsf@ebiederm.dsl.xmission.com>
	 <20060714163905.GB25303@sergelap.austin.ibm.com>
	 <m1mzbct895.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 10:24:06 -0700
Message-Id: <1152897846.24925.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 11:18 -0600, Eric W. Biederman wrote:
> /proc/<pid>/fd/...
> /proc/<pid>/exe
> /proc/<pid>/cwd
> 
> It isn't quite the same as you are actually opening a second
> copy of the file descriptor but the essence is the same. 

Last I checked, those were symlinks and didn't work for things like
deleted files.  Am I wrong?

-- Dave

