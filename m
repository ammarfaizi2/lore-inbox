Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270920AbTGQUyR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271011AbTGQUyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:54:17 -0400
Received: from murphys.services.quay.plus.net ([212.159.14.225]:35997 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id S270920AbTGQUyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:54:15 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "James Simmons" <jsimmons@infradead.org>, <junkio@cox.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: "Where's the Beep?" (PCMCIA/vt_ioctl-s)
Date: Thu, 17 Jul 2003 22:09:15 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAIEMGEOAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <Pine.LNX.4.44.0307151750090.7746-100000@phoenix.infradead.org>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James.

 >>>> On my old DELL LM laptop the -2.5 series no longer issues
 >>>> any beeps when a card is inserted.  The problem is in the
 >>>> kernel, as the test program below (extracted from cardmgr)
 >>>> beeps on -2.4, but not on -2.5.

 >>> CONFIG_INPUT_PCSPKR needs to be =y (or =m and the module
 >>> loaded).

 >> That's true, but I wonder why PC Speaker is under *INPUT*
 >> category...

 > Because many keyboards have built in speakers.

What sort of logic is that !!!

The ONLY reason I can think of for treating a speaker as an INPUT
device is if that speaker is wired up in a way that allows it to
be used as a microphone, the way some baby-intercoms do. If this
is the reason, then don't expect any sort of quality from it, and
please also separate this use from the more conventional one.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.501 / Virus Database: 299 - Release Date: 14-Jul-2003

