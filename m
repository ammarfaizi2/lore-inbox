Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVFWNif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVFWNif (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 09:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVFWNif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 09:38:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40096 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261900AbVFWNfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 09:35:19 -0400
Date: Thu, 23 Jun 2005 15:35:16 +0200
From: Jan Kara <jack@suse.cz>
To: Przemyslaw Sowa <sowa.przemyslaw@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intercepting VFS calls
Message-ID: <20050623133516.GH28670@atrey.karlin.mff.cuni.cz>
References: <405bb5a1050620073741a589f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <405bb5a1050620073741a589f9@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Frederik Deweerdt wrote:
> 
> > Le 20/06/05 12:37 +0200, Przemyslaw Sowa écrivit:
> >  
> >
> >> Hello,
> >>
> >> I'd like to intercept VFS calls like read() and write() in 2.6
> kernels but I'm new in kernel development and I don't know how to do
> it.
> >>
> >> Could you help me, please?
> >>
> >>   
> >
> > You could have a look at kprobes.
> > Regards,
> > Frederik Deweerdt
> >
> >  
> >
> Thank you for the answer, but I need some way to execute my own
> function (from a module) instead of read(), wrte()... and I don't want
> to use any kernel patch. Is it possible?
  It's impossible without patching the kernel. Why do you want to
intercept the calls? Isn't it enough to intercept the system calls? Then
you can do it from the userspace by tracing the process.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
