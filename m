Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbSLAUIZ>; Sun, 1 Dec 2002 15:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbSLAUIZ>; Sun, 1 Dec 2002 15:08:25 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:32737 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S262317AbSLAUIY>; Sun, 1 Dec 2002 15:08:24 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: [2.4.20] alpha (alcor) failing during boot: NCR53c810/NCR53c875 give error "Cache test failed"
Date: Sun, 1 Dec 2002 21:15:50 +0100
Message-ID: <002e01c29976$71c12830$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My Dec Alpha (Alcor) runs fine with 2.2.20.
With 2.4.20, it fails during boot at the init. of the scsi-devices.
Error is:
CACHE TEST FAILED: dma error (dstat=0xa0).sym0: CACHE INCORRECTLY CONFIGURED
I tried a kenel with: NCR53C8XX and SYM53C8XX compiled in, and I tried
a kernel with SYM53C8XX support neither of them work. Both give same error.
What can be the cause of this?


Folkert van Heusden
[ www.vanheusden.com ]

