Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbVHPRut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbVHPRut (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 13:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbVHPRut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 13:50:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:14992 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030262AbVHPRut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 13:50:49 -0400
Date: Tue, 16 Aug 2005 10:50:20 -0700
From: Greg KH <greg@kroah.com>
To: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process
Message-ID: <20050816175019.GA31002@kroah.com>
References: <1123868902.10923.5.camel@w2> <20050813221148.GA20060@kroah.com> <1124213674.9316.15.camel@w2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124213674.9316.15.camel@w2>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 07:34:34PM +0200, Wieland Gmeiner wrote:
> On Sat, 2005-08-13 at 15:11 -0700, Greg KH wrote:
> > On Fri, Aug 12, 2005 at 07:48:22PM +0200, Wieland Gmeiner wrote:
> > > @@ -294,3 +294,4 @@ ENTRY(sys_call_table)
> > >  	.long sys_inotify_init
> > >  	.long sys_inotify_add_watch
> > >  	.long sys_inotify_rm_watch
> > > +        .long sys_getprlimit
> > 
> > Please follow the proper kernel coding style when writing new kernel
> > code...
> 
> Hm, Documentation/CodingStyle suggests using descriptive names, so
> something like getrlimit(...)/getrlimit_per_process(pid_t pid, ...)
> would be more appropriate?
> 
> I thought getrlimit(...)/getprlimit(pid_t pid, ...) would be a good
> choice as getgid(void)/getpgid(pid_t pid) already exists in Linux which
> have the same naming scheme.
> 
> Or would something like
> getrlimit/getrlimitpid (like wait(void)/waitpid(pid)) or
> getrlimit/getrlimit2 (like getpgrp(void)/getpgrp2(pid) in HP-UX)
> be preferred?
> 
> What would you suggest?

You use tabs instead of spaces :)

thanks,

greg k-h
