Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270716AbTGUUNN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 16:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270717AbTGUUNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 16:13:13 -0400
Received: from msgbas2x.cos.agilent.com ([192.25.240.37]:59890 "EHLO
	msgbas2x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S270716AbTGUUNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 16:13:05 -0400
Message-ID: <334DD5C2ADAB9245B60F213F49C5EBCD05D5521E@axcs03.cos.agilent.com>
From: yiding_wang@agilent.com
To: yiding_wang@agilent.com, linux-kernel@vger.kernel.org
Cc: sartre@linuxbr.com
Subject: RE: 2.5.72 insmod question again - ignore please
Date: Mon, 21 Jul 2003 14:28:05 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore about the question.  I am getting further but still trying to figure out since the procedure mentioned in README file and FAQ do not quite fit in my case.

Thanks!

Eddie

> -----Original Message-----
> From: yiding_wang@agilent.com [mailto:yiding_wang@agilent.com]
> Sent: Monday, July 21, 2003 11:20 AM
> To: linux-kernel@vger.kernel.org
> Cc: sartre@linuxbr.com
> Subject: 2.5.72 insmod question again
> 
> 
> Hello ,
> 
> I have patched the module update 0.9.13-pre and rebuilt 
> kernel.  However, the insmod is still complainthe same thing 
> because the utility is still from 2.4.20-8.  This driver 
> module is not going to be loaded during the kernel boot.  I 
> want to use insmod to load the module.  I tried load 
> qla1280.o built with kernel and got the same result.
> 
> I think I may either need a new insmod utility to load the 
> module,  missed something or need to follow different 
> procedure.  Any idea from this point?
> 
> By the way, I am using RH 9.0 release as base system fo 
> r2.5.72 upgrade.
> 
> Thanks!
> 
> Eddie
> 
> > -----Original Message-----
> > From: Cesar Suga [mailto:sartre@linuxbr.com]
> > Sent: Friday, July 18, 2003 5:27 AM
> > To: yiding_wang@agilent.com
> > Subject: RE: 2.5.72 insmod question
> > 
> > 
> > On Fri, 2003-07-18 at 14:50, yiding_wang@agilent.com wrote:
> > 
> > 	You're welcome;
> > 
> > 	I've come with some shortcomings upgrading, too...
> > 
> > 	[]s,
> > 	Cesar Suga <sartre@linuxbr.com>
> > 
> > > Thanks for the help!
> > > 
> > > > -----Original Message-----
> > > > From: Cesar Suga [mailto:sartre@linuxbr.com]
> > > > Sent: Friday, July 18, 2003 3:00 AM
> > > > To: yiding_wang@agilent.com
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Subject: Re: 2.5.72 insmod question
> > > > 
> > > > 
> > > > On Thu, 2003-07-17 at 21:35, yiding_wang@agilent.com wrote:
> > > > 
> > > > 	Hello,
> > > > 
> > > > 	Install the 'module-init-tools' package, from:
> > > > 
> > > > 	
ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules/
> > > 
> > > 	This is required for the new series of kernels, 
> > > starting with 2.5.50 (I
> > > think), 2.5.72 certainly requires it.
> > > 
> > > 	Cheers,
> > > 	Cesar Suga <sartre@linuxbr.com>
> > > 
> > > > I completed a fibre channel driver change to support for 
> > > 2.5.72 (suppose to be 2.6 compatible) and compiled it OK.  
> > > When trying load the driver with "insmod", it complains with 
> > > the message "insmod: QM_MODULES: Function not implemented".
> > > > 
> > > > I tried kernel built module qla1280.o and got the same 
> > > result.  It seems the insmod utility in my system is not 
> > > compatible with new 2.5.72 built module.
> > > > 
> > > > I have 2.4.20-8 kernel installed first and driver loads and 
> > > runs fine.  Later added 2.5.72 kernel and booted with its 
> > > bzImage works fine too.  However, the insmod utility I am 
> > > using to load new driver was from 2.4.20-8 which has 
> > > system_query_module() being called.  I checked Doc. and 
> > > source code for 2.5.72 and could not find same function call 
> > > in module.c
> > > > 
> > > > Some web documents mentioned that the module installation 
> > > is changed from 2.4.x to 2.5.x.  So far I am still looking 
> > > for the solution and hope someone can help me on the issue.
> > > > 
> > > > I am compiling the driver out side of kernel source tree 
> > > but using kernel environmental variables for compatibility.
> > > > 
> > > > Regards,
> > > > 
> > > > Eddie
> > > > 
> > > >  
> > > > 
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe 
> > > linux-kernel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  
http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > > 
> > 
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
