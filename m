Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSK0BAZ>; Tue, 26 Nov 2002 20:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSK0BAZ>; Tue, 26 Nov 2002 20:00:25 -0500
Received: from oe39.law11.hotmail.com ([64.4.16.96]:16909 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262394AbSK0BAY>;
	Tue, 26 Nov 2002 20:00:24 -0500
X-Originating-IP: [64.81.213.196]
From: "Dino Klein" <dinoklein@hotmail.com>
To: <adamk@voicenet.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE:  2.5.49 module problem
Date: Tue, 26 Nov 2002 20:07:46 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <OE39UA93Nii59RkIM7X000073e3@hotmail.com>
X-OriginalArrivalTime: 27 Nov 2002 01:07:37.0816 (UTC) FILETIME=[605B9580:01C295B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I went through the same problem. as of 2.5.48, the old modutils don't work,
and you need to grab the new stuff from the link below.
when you install them, they will rename the old insmod/rmmod/modprobe to
*.old.
if you drop down to 2.4 again, then the new utils will simply call the old
ones, so it is pretty transparent.
I really don't know where it's written about this change, but I went through
a lot of pain to find this out. perhaps I just missed the obvious in some
readme file...

http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
