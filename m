Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265610AbSKFCdL>; Tue, 5 Nov 2002 21:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265550AbSKFCdK>; Tue, 5 Nov 2002 21:33:10 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:2737 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S266060AbSKFCbO>; Tue, 5 Nov 2002 21:31:14 -0500
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: When laptop is docked, eth0 moves from pcmcia to dockingstation nic (Linux needs path_to_inst)
Date: Tue, 5 Nov 2002 18:41:34 -0800
Message-ID: <001501c2853e$05b26880$0472e50c@peecee>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <1036520337.4791.111.camel@irongate.swansea.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>You can ask for the MAC or PCI address of an interface

Where do I do this? 


, and you can
>rename interfaces if you wish. The Red Hat 8.0 scripts are one example
>that supports this

I don't need to rename them, I need them to stay put, or have some kind
of control over which NIC becomes eth0 and which NIC becomes eth1.

This makes me wonder about running Linux on large systems. How do you
make sure that if you have 2 NICS and you populate PCI slots 3 and 2,
what happens when you add another NIC in slot 0? Do the devices shift?
How do you get them to stay put?

What about SCSI cards? Does logical volume manager software tolerate
LUNS moving around when SCSI interfaces shift?

It seems there needs to be better control over this, something like
path_to_inst in Solaris?

--Buddy

