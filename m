Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265777AbUGMUGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265777AbUGMUGh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 16:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265790AbUGMUGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 16:06:37 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:12781 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265777AbUGMUGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 16:06:34 -0400
Subject: Re: question about ramdisk
From: Lee Revell <rlrevell@joe-job.com>
To: lya755@ece.northwestern.edu
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1089727279.40f3eb2f82a6c@core.ece.northwestern.edu>
References: <1089651469.40f2c30d44364@core.ece.northwestern.edu>
	 <ccugqu$tun$1@terminus.zytor.com>
	 <1089727279.40f3eb2f82a6c@core.ece.northwestern.edu>
Content-Type: text/plain
Message-Id: <1089749203.22026.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 16:06:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Unix Internals", by Uresh Vahalia (sp?).  This book went everywhere I
did for a year.  I cannot praise it highly enough.  Read that, then get
Robert Love's 'Linux Kernel Programming'.

Lee

On Tue, 2004-07-13 at 10:01, lya755@ece.northwestern.edu wrote:
> Thank you! Can you pls tell me where I can find related references? I've been 
> looking into several books about kernel and part of the kernel code, but no 
> luck so far.. 
> 
> Thanks for any comments!
> 
> Quoting "H. Peter Anvin" <hpa@zytor.com>:
> 
> > Followup to:  <1089651469.40f2c30d44364@core.ece.northwestern.edu>
> > By author:    lya755@ece.northwestern.edu
> > In newsgroup: linux.dev.kernel
> > >
> > > Hi all,
> > > 
> > > I am learning linux kernel and have a question about ramdisk. When loading
> > an 
> > > executable in ramdisk, is the kernel loading the code all at a time to
> > memory 
> > > and then execute, or is it loading only a page at one time and generating a
> > 
> > > page fault to fetch another page?
> > > 
> > > Thanks for any comments! Waiting desprately for your help.
> > > 
> > 
> > Neither.  The code is already in RAM.  It's mapped into the process
> > address space and run in place.
> > 
> > 	-hpa
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
> 
> _________________________________________________________
> This message was sent through the NU ECE webmail gateway.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

