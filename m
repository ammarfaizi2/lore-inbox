Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274834AbRIZF3S>; Wed, 26 Sep 2001 01:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274833AbRIZF3J>; Wed, 26 Sep 2001 01:29:09 -0400
Received: from WARSL401PIP3.highway.telekom.at ([195.3.96.75]:61267 "HELO
	email02.aon.at") by vger.kernel.org with SMTP id <S274834AbRIZF2v>;
	Wed, 26 Sep 2001 01:28:51 -0400
From: "Michael Guntsche" <m.guntsche@epitel.at>
To: <linux-kernel@vger.kernel.org>
Subject: Spurious Interrupt in 2.4.10
Date: Wed, 26 Sep 2001 07:08:50 +0200
Message-ID: <NDBBJOKGIPCDBEEFHNFPGENFCAAA.m.guntsche@epitel.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

After upgrading my kernel from 2.4.8 to the latest 2.4.10 I started getting
following error message in my logs.

	spurious 8259A interrupt: IRQ7.

Looking at /proc/interrupts showed me that interrupt 7 wasnt taken by
anything and that the ERR count was slowly increasing.
This happens on an Asus K7V with the KX133 chip and an old Athlon 700.
Since I don't have the slightest clue what a spurious interrupt is I don't
really know how to debug this.

Thanks for the help,
Michael

PS: Please CC any replies to me since Im not subscribed to the list.

