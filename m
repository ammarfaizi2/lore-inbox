Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266322AbSLSVs3>; Thu, 19 Dec 2002 16:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266507AbSLSVs3>; Thu, 19 Dec 2002 16:48:29 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:128 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S266322AbSLSVs3>; Thu, 19 Dec 2002 16:48:29 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: problem with 2.4.20 and OPTi Inc. 82C861 (rev 10) USB card
Date: Thu, 19 Dec 2002 22:56:04 +0100
Message-ID: <000001c2a7a9$6e231620$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a OPTi Inc. 82C861 (rev 10) USB card in my pentium 90 pc.
The output of lspci gives me this:
00:07.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
        Subsystem: OPTi Inc. 82C861
        Flags: medium devsel
        Memory at 10000000 (32-bit, non-prefetchable) [size=4K]

The driver should be the ohci, but when I modprobe that one, I
get the following error:
spider:/home/folkert# modprobe usb-ohci
/lib/modules/2.4.20/kernel/drivers/usb/usb-ohci.o: init_module: No such
device
Hint: insmod errors can be caused by incorrect module parameters, including
invalid IO or IRQ parameters

So I was wondering: can it be that the USB-driver is slightly
broken? :-)

(oh, all the other usb-drivers give the same errors)

