Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267471AbTCFAt5>; Wed, 5 Mar 2003 19:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTCFAt4>; Wed, 5 Mar 2003 19:49:56 -0500
Received: from mail.casabyte.com ([209.63.254.226]:31758 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP
	id <S267471AbTCFAt4>; Wed, 5 Mar 2003 19:49:56 -0500
From: "Robert White" <rwhite@casabyte.com>
To: <linux-kernel@vger.kernel.org>
Subject: PNP Support for PCI bus
Date: Wed, 5 Mar 2003 17:00:27 -0800
Message-ID: <PEEPIDHAKMCGHDBJLHKGOEPCCBAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Someone just brought me a laptop (Toshiba Satellite 5205-S505) that does not
allow you to access the BIOS.  It has a one question setup "reset defaults
(Y/N)?".  They wanted me to put Linux on the beast.

The thing is, the inaccessible bios is strictly plug and pray.

The (2.4.18) kernel contains a plug-and-pray enumerator for the ISA bus, but
not the PCI bus.

Is anybody working on this (or does it already exist) somewhere?  It would
seem that such a beast "would only" have to do what the bios does (populate
registers in the chipset to define INT#A through INT#D) with otherwise
unused values. (I love it when people use any variant of "couldn't you just"
in a requirements proposal don't you? 8-)

My immediate patch was to send the guy back to the store to exchange the
laptop for something that didn't suck.

Meanwhile I suspect that we are going to be seeing more of this sort of
thing.  While I have time to contribute I have now exhausted my knowledge of
PCI internals, so rather than adding something to make me look even more
stupid I will just pose the question... (I'm an application-level
programmer... 8-)

Rob.

