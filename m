Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263300AbTCNNwi>; Fri, 14 Mar 2003 08:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263332AbTCNNwi>; Fri, 14 Mar 2003 08:52:38 -0500
Received: from rammstein.mweb.co.za ([196.2.53.175]:59874 "EHLO
	rammstein.mweb.co.za") by vger.kernel.org with ESMTP
	id <S263300AbTCNNwh>; Fri, 14 Mar 2003 08:52:37 -0500
To: Miguel =?ISO-8859-1?Q?Quir=F3s?= <mquiros@ugr.es>,
       linux-kernel@vger.kernel.org
From: bonganilinux@mweb.co.za
Subject: Re: make modules_install fail: depmod *** Unresolved symbols (official
Date: Fri, 14 Mar 2003 14:03:06 GMT
X-Posting-IP: 196.34.86.10 via 172.24.158.16
X-Mailer: Endymion MailMan Standard Edition v3.2.18
Message-Id: <E18tpXR-0007oI-00@rammstein.mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 			Granada, 14-3-2002
> 
> Hello, I downloaded kernel 2.4.20 and compiled it sucessfully a month
> ago without any aparent problem. Yesterday I tried to compile it again
> in the same computer just changing a couple of small things in the
> configuration (agpart and the network card changed from "module" to
> "yes").
> 
> make dep, make bzImage and make modules went apparently well (expect for
> a few apparently non-important warnings with bzImage of the type
> Warning: indirect call without '*' when compiling pci-pc and apm).
> 
> But when I try make modules_install, I've got a lot of error messages.
> For each module I've got one line like:
> 
> depmod:  *** Unresolved symbols in
> /lib/modules/2.4.20/kernel/arch/i386/kernel/microcode.o
> 
> followed by a number of lines of the type
> 
> depmod:     misc_deregister
> depmod:     __generic_copy_from_use
> depmod:     .....

Download, compile and install Rusty's latest module-init-tools
ftp.kernel.org/pub/linux/kernel/people/rusty/modules

---------------------------------------------
This message was sent using M-Web Airmail - JUST LIKE THAT
M-Web: S.A.'s most trusted and reliable Internet Service Provider.
http://airmail.mweb.co.za/


