Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317708AbSHGNMD>; Wed, 7 Aug 2002 09:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317730AbSHGNMC>; Wed, 7 Aug 2002 09:12:02 -0400
Received: from [193.28.17.2] ([193.28.17.2]:11015 "EHLO aov.de")
	by vger.kernel.org with ESMTP id <S317708AbSHGNMC>;
	Wed, 7 Aug 2002 09:12:02 -0400
Message-ID: <8E9ADA855450D511A73B0008C70D721F521510@nt09901.aov.de>
From: "Euler, Christian" <euler@rz.aov.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Problems with various networking-cards (tulip,3c59x,etc.) on 
	2.4.19-smp machine
Date: Wed, 7 Aug 2002 15:15:37 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACK

We've experienced the same problem with a 2.4.18-smp kernel.

/var/log/messages said :

Aug  6 13:09:28 li09903 kernel: eth0: Intel(R) 8255x-based Ethernet Adapter
Aug  6 13:09:31 li09903 kernel:   Mem:0xf6408000  IRQ:18  Speed:0 Mbps
Dx:N/A
Aug  6 13:09:31 li09903 kernel:   Failed to detect cable link.
Aug  6 13:09:31 li09903 kernel:   Speed and duplex will be determined at
time of connection.
Aug  6 13:09:31 li09903 kernel:   Hardware receive checksums disabled

Setting link parameters via module options solved the problem here.

Chris
