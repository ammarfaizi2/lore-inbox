Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTJ1N3O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 08:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTJ1N3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 08:29:14 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:59853 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S263971AbTJ1N3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 08:29:02 -0500
Message-ID: <01ee01c39d57$6f69dbf0$19de4c0f@nta2225>
From: "Vishwanath Kalbagilmath" <kalbagil@india.hp.com>
To: "John S J Anderson" <jacobs@genehack.org>
Cc: <ma-linux@tux.org>, <linux-kernel@vger.kernel.org>
References: <0cfa01c3931a$1b13a190$19de4c0f@nta2225> <87vfqqzm9x.fsf@mendel.genehack.org>
Subject: Re: [ma-linux] problem loading module
Date: Tue, 28 Oct 2003 18:58:53 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

After including some of the versioning header files and some macros like
MODVERSIONS, I am still unable to load the module into the kernel.
Now the printk(), kmalloc() problems are solved, now only left out 
is unresolved symbol is register_chrdev_Rsmp_904e3677 but ksyms has 
register_chrdev_Rsmp_e337b494
Please let me know where I am making mistake...

Thanks in Adv
Vishwanath


----- Original Message ----- 
From: "John S J Anderson" <jacobs@genehack.org>
To: "Vishwanath Kalbagilmath" <kalbagil@india.hp.com>
Cc: <ma-linux@tux.org>
Sent: Wednesday, October 15, 2003 6:32 PM
Subject: Re: [ma-linux] problem loading module


> "Vishwanath Kalbagilmath" <kalbagil@india.hp.com> writes:
> 
> > these are the unresolved symbols that I get when trying the loadable
> > module in RH 7.3 and RHAS 2.1 as well, can anybody suggest some soln
> > to this...
> >
> > mydrv.o: unresolved symbol unregister_chrdev_Rc192d491
> > mydrv.o: unresolved symbol register_chrdev_Rd115e0a6
> > mydrv.o: unresolved symbol snprintf_Raf25400d
> > mydrv.o: unresolved symbol kmalloc_R6f6c1cf7
> > mydrv.o: unresolved symbol printk_R827d5807
> 
>   If you're not seeing printk(), you're almost certainly doing
>   something wrong. Have you looked at the Module HOWTO?
> 
> <http://www.tldp.org/HOWTO/Module-HOWTO/index.html>
> 
> john.
> -- 
> Linux's power is that we FIX stuff. That we make it the best system
> possible, and that we don't just whine and argue about things.
>   -- Linus Torvalds in 
>      <Pine.LNX.4.44.0205070827050.1343-100000@home.transmeta.com>
> 

