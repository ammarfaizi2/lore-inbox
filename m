Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275789AbRJNRSv>; Sun, 14 Oct 2001 13:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275816AbRJNRSe>; Sun, 14 Oct 2001 13:18:34 -0400
Received: from lawcv2.lcisp.com ([12.44.138.11]:2313 "EHLO lcisp.com")
	by vger.kernel.org with ESMTP id <S275789AbRJNRRQ>;
	Sun, 14 Oct 2001 13:17:16 -0400
From: "Kevin Krieser" <kkrieser_list@footballmail.com>
To: "Stanislav Meduna" <stano@meduna.org>, <linux-kernel@vger.kernel.org>
Subject: RE: USB stability - possibly printer related
Date: Sun, 14 Oct 2001 12:17:41 -0500
Message-ID: <NDBBLFLJADKDMBPPNBALAEHFGAAA.kkrieser_list@footballmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <200110141544.f9EFiGN01608@meduna.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know I've attempted to use the same IBM hard drive on the HPT366
controller with little success.  I got hangups until I moved it back to the
secondary IDE controller.

Otherwise, with 2.4.8 I could print to my Lexmark E310 printer using USB
fine.

One thing I have noticed is that, with the 2.4 kernels, my system doesn't
like sharing IRQs as well as the 2.2 kernels.  So you may want to see what
devices share interrupts with your USB controller, and move the cards if
necessary.


