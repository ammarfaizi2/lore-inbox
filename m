Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266353AbSLCWku>; Tue, 3 Dec 2002 17:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266359AbSLCWku>; Tue, 3 Dec 2002 17:40:50 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:27140 "EHLO
	lap.molina") by vger.kernel.org with ESMTP id <S266353AbSLCWkt>;
	Tue, 3 Dec 2002 17:40:49 -0500
Date: Tue, 3 Dec 2002 16:39:36 -0600 (CST)
From: Thomas Molina <tmolina@copper.net>
X-X-Sender: tmolina@lap.molina
To: PlasmaJohn <lkml@projectplasma.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: sound is stutter, sizzle with lasts kernel releases
In-Reply-To: <Pine.LNX.4.44.0212022353060.13961-100000@bard.cbnet>
Message-ID: <Pine.LNX.4.44.0212031636140.1170-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2002, PlasmaJohn wrote:

> Please excuse me if I'm being naive, but aren't SBlive cards really bad bus
> citizens and have problems on SMP machines, Via chipsets, etc.?
> 
> Or did Linux fix what Creative and Microsoft couldn't.  Or won't.  ;)

SBline doesn't share interrupts well.  Usually, changing PCI slots in 
order to affect what interrupt is used can help a lot.  The problem is, 
depending on the motherboard, figuring out what a particular PCI slot 
shares an interrupt with can be difficult.

