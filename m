Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUGMOFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUGMOFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 10:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265133AbUGMOFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 10:05:54 -0400
Received: from core.ece.northwestern.edu ([129.105.5.1]:59333 "EHLO
	core.ece.northwestern.edu") by vger.kernel.org with ESMTP
	id S265086AbUGMOFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 10:05:40 -0400
Message-ID: <1089727279.40f3eb2f82a6c@core.ece.northwestern.edu>
Date: Tue, 13 Jul 2004 09:01:19 -0500
From: lya755@ece.northwestern.edu
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about ramdisk
References: <1089651469.40f2c30d44364@core.ece.northwestern.edu> <ccugqu$tun$1@terminus.zytor.com>
In-Reply-To: <ccugqu$tun$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 138.15.107.179
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you! Can you pls tell me where I can find related references? I've been 
looking into several books about kernel and part of the kernel code, but no 
luck so far.. 

Thanks for any comments!

Quoting "H. Peter Anvin" <hpa@zytor.com>:

> Followup to:  <1089651469.40f2c30d44364@core.ece.northwestern.edu>
> By author:    lya755@ece.northwestern.edu
> In newsgroup: linux.dev.kernel
> >
> > Hi all,
> > 
> > I am learning linux kernel and have a question about ramdisk. When loading
> an 
> > executable in ramdisk, is the kernel loading the code all at a time to
> memory 
> > and then execute, or is it loading only a page at one time and generating a
> 
> > page fault to fetch another page?
> > 
> > Thanks for any comments! Waiting desprately for your help.
> > 
> 
> Neither.  The code is already in RAM.  It's mapped into the process
> address space and run in place.
> 
> 	-hpa
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



_________________________________________________________
This message was sent through the NU ECE webmail gateway.
