Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267701AbSLGCTq>; Fri, 6 Dec 2002 21:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267706AbSLGCTq>; Fri, 6 Dec 2002 21:19:46 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:46856 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267701AbSLGCTp>; Fri, 6 Dec 2002 21:19:45 -0500
X-Envelope-From: roubm9am@barbora.ms.mff.cuni.cz
Message-ID: <068d01c29d97$f8b92160$551b71c3@krlis>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: <linux-kernel@vger.kernel.org>
Subject: IDE feature request
Date: Sat, 7 Dec 2002 03:25:50 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to you,
I tryed to find patch for kernel that allows more than
10 ide devices instaled on system with no luck.
I tryed to patch the kernel by myself, so it works,
but the patch is only change magic number 10 to 12.
I have got this:
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x3020-0x3027,0x3016 on irq 11
ide3 at 0x3018-0x301f,0x3012 on irq 11
ide4 at 0x5040-0x5047,0x5036 on irq 12
ide6 at 0x5058-0x505f,0x504e on irq 12
ide7 at 0x5050-0x5057,0x504a on irq 12
ide8 at 0x5070-0x5077,0x5066 on irq 12
ide9 at 0x5068-0x506f,0x5062 on irq 12
ide: at 0x6020-0x6027,0x6016 on irq 12
ide; at 0x6018-0x601f,0x6012 on irq 12
so ":" and ";" isn't ideal, hdparm dislikes 
my devices hdx and so on. Now I would like to try
more than 20 ide devices in one computer and I would like
to hear about any system solution of this real problem 
to me. If the number of IDE devices supported will be increased
to 32, I think it would be ideal to any time. 
Is there any special reason why is there maximum 10 IDE devices?
    Thanx for answer
    Milan Roubal
    roubm9am@barbora.ms.mff.cuni.cz

