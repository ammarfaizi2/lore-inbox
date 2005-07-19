Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVGSSFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVGSSFY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 14:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVGSSFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 14:05:23 -0400
Received: from web60711.mail.yahoo.com ([209.73.178.214]:30061 "HELO
	web60711.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261480AbVGSSFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 14:05:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=X5Qh5/tuusaSeX6LPLhqbXn+5IttPqe1vGuR4CCK1OYcMuuXjHH6qG2T6yLtpwR83IymXwQB+DdIO7UDkAQTy/zM5RsMGkFFC4hmy39KgCL2uw1RW8nn/Z1lmP9FwenqY7ZShMQATUNb4ZFxBLiXbti6JHIuGawcDoaUZsFLONA=  ;
Message-ID: <20050719180521.8914.qmail@web60711.mail.yahoo.com>
Date: Tue, 19 Jul 2005 15:05:21 -0300 (ART)
From: "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br>
Subject: Kernel 2.6.12 and 2.6.13 hangs for a while on boot
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi all,

I'm having little hangs while booting with kernels 2.6.12 and 2.6.13-rc1, rc2
and rc3.

It is strange that 2.6.12-rc1 booted ok without hangs.

I saw a post of Alan Cox on rc-1 release notes:

"Old ISA/VESA systems sometimes put tertiary IDE controllers at addresses
    0x1e8, 0x168, 0x1e0 or 0x160.  Linux thus probes these addresses on x86
    systems.  Unfortunately some PCI systems now use these addresses for other
    purposes which leads to users seeing minute plus hangs during boot or even
    crashes."

I thought this could be my problem, but it still hangs on boot.

Hangs appears just before mounting filesystems message and before configuring
system to use udev.

I'm using Gentoo with vanilla-sources. I already asked on gentoo lists and
nobody saw this behaviour. I tried google with no luck too. So my last resource
which could give me some light is here.

I'm using 2.6.13 on a Gateway laptop.

Do you know of something about this? Have you seen this problem?
Where could I look for more information about that in my system? I saw logs but
they don't say anything. Also, besides this hangs on boot, system seems to work
perfectly, but I'd like to remove this hangs from boot.

For while, I'm using 2.6.11.10 which is working ok.

Thanks in advance.

--
Regards,

Francisco Figueiredo Jr.



	
	
		
_______________________________________________________ 
Yahoo! Acesso Grátis - Internet rápida e grátis. 
Instale o discador agora! http://br.acesso.yahoo.com/
