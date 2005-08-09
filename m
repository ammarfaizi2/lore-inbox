Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbVHIQKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVHIQKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbVHIQKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:10:30 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:3203 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964852AbVHIQK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:10:29 -0400
Subject: Re: irqpoll causing some breakage?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-kernel@vger.kernel.org, mog.johnny@gmx.net
In-Reply-To: <42F7FD5E.6000107@gentoo.org>
References: <42F7FD5E.6000107@gentoo.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 09 Aug 2005 17:36:59 +0100
Message-Id: <1123605419.15600.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-09 at 01:48 +0100, Daniel Drake wrote:
> After the irqpoll patch has been applied, the mouse does not work (the 
> keyboard works fine..!). This is without the irqpoll/irqfixup parameters, 
> although adding them does not help either. No errors appear, as far as I can see.

Without the parameters it has exactly zero effect on the operation of
the kernel, the algorithms and the behaviour. So something odd is afoot
if its causing gentoo breakages. Do you see this using a reasonably
trustworthy compiler suite as we've not seen it on Fedora ?

If you do does the box log any stuck IRQ's during boot without the
patch 

