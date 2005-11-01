Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbVKARON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVKARON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbVKARON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:14:13 -0500
Received: from mail.enyo.de ([212.9.189.167]:21635 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1750992AbVKAROL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:14:11 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Lawrence Walton <lawrence@the-penguin.otak.com>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 3ware 9550SX problems - mke2fs incredibly slow writing last third of inode tables
References: <BEDEA151E8B1D6CEDD295442@[192.168.100.25]>
	<87oe54cza8.fsf@mid.deneb.enyo.de>
	<20051101170413.GA11640@the-penguin.otak.com>
Date: Tue, 01 Nov 2005 18:13:59 +0100
In-Reply-To: <20051101170413.GA11640@the-penguin.otak.com> (Lawrence Walton's
	message of "Tue, 1 Nov 2005 09:04:13 -0800")
Message-ID: <87wtjs8f54.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lawrence Walton:

>> In my experience, the 3ware SATA controllers which are not NCQ-capable
>> have very, very lousy write performance with some drives, unless you
>> enable the write cache (which is, of course, a bit dangerous without
>> UPS or battery backup on the controller).

> Not to sound like the a 3ware chearleader, but this card does support NCQ.

Oh.  I didn't know whether this particukar controller supported NCQ or
not.

BTW, does anybody know if NCQ support is available for the 9500S in a
firmware upgrade?
