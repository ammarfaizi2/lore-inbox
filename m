Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267112AbTAKCRS>; Fri, 10 Jan 2003 21:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267115AbTAKCRS>; Fri, 10 Jan 2003 21:17:18 -0500
Received: from f166.law14.hotmail.com ([64.4.21.166]:4623 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267112AbTAKCRS>;
	Fri, 10 Jan 2003 21:17:18 -0500
X-Originating-IP: [200.226.148.147]
From: "Adriano Carvalho" <ch0wn_@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Ethernet card doesnt work in 2.4.20 
Date: Sat, 11 Jan 2003 00:24:37 -0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <F166UKfLDeyZEjpzRsf00017394@hotmail.com>
X-OriginalArrivalTime: 11 Jan 2003 02:24:38.0256 (UTC) FILETIME=[96F18700:01C2B918]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--
I have a Compaq Laptop 1400 14xl244, with Modem HCF conexant , and ethernet 
card Conexant LANfinity. They are COMBO, and they use IRQ 11. When I startup 
module (tulip) for my ethernet card, its ok. But when I try send or receive 
anything, I dont get. PCMCIA card uses IRQ 11 too, so I get it out from 
kernel, but it doesnt solve. Here is my /proc/interrupts :

11: 20 XT-PIC hcf, eth0 this was after a time of try ping, and the number 
"20" after stays 1691, after 2000... Donald Becker (tulip developer) told me 
to send these lines : Compaq 12XL125 machine detected. Enabling interrupts 
during APM calls. ... Local APIC disabled by BIOS -- reenabling. Found and 
enabled local APIC! .. PCI: Using IRQ router VIA [1106/0686] at 00:07.0 PCI: 
Found IRQ 11 for device 00:0a.0 PCI: Sharing IRQ 11 with 00:09.0 PCI: 
Sharing IRQ 11 with 00:09.1 PCI: Disabling Via external APIC routing

Thanks for all.

Adriano Carvalho.

_________________________________________________________________
MSN Messenger: converse com os seus amigos online. 
http://messenger.msn.com.br

