Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSEUOX5>; Tue, 21 May 2002 10:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314637AbSEUOX4>; Tue, 21 May 2002 10:23:56 -0400
Received: from edcom.no ([194.248.172.30]:57609 "EHLO edcom.no")
	by vger.kernel.org with ESMTP id <S314634AbSEUOX4>;
	Tue, 21 May 2002 10:23:56 -0400
From: "Svein E. Seldal" <Svein.Seldal@edcom.no>
To: <linux-kernel@vger.kernel.org>
Subject: Custom kernel version and depmod
Date: Tue, 21 May 2002 16:23:54 +0200
Message-ID: <KKEHJJLHENOALGODMOGLCECHCBAA.Svein.Seldal@edcom.no>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have written a USB device driver for the Linux kernel. For convenience I
am going to distribute it binary (rpm) in addition to the source. For
flexibility I intended to distribute the module without enabling the kernel
module version. However, depmod complains about unresolved symbols if I do
so (insmod/modprobe works of course). Is there a method of avoiding these
complaints by depmod or must I compile the driver with the kernel module
enabled (i.e. depmod is made this way).


Regards,
Svein

