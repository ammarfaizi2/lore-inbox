Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267445AbUG2Vh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUG2Vh6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUG2Vh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:37:58 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:36817 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id S267445AbUG2VeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:34:04 -0400
Date: Thu, 29 Jul 2004 13:40:01 -0700 (PDT)
From: alan <alan@clueserver.org>
X-X-Sender: alan@www.fnordora.org
To: Rogier Wolff <Rogier@wolff.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OK, anybody have any hints and tips to get an MFM drive working
 again?
In-Reply-To: <20040729201458.GA19252@bitwizard.nl>
Message-ID: <Pine.LNX.4.44.0407291336470.29726-100000@www.fnordora.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004, Rogier Wolff wrote:

> We need to recover some data off an old MFM drive. We've got a bunch
> of those cards, we've got a bunch of drives to experment with, but 
> once we get things working we'll recover some 2x20Mb of data off two
> 20Mb drives....
> 
> We've tried the modern IDE driver, and the 2.4.20 one, and the "old
> hd only" driver. 
> 
> Going "retro": Compiling 2.0.39 gives me: "bus error" while doing 
> make dep. 
> 
> I THINK we have a couple of those cards that don't have any 
> interrupts. Would Linux be able to work with those?
> 
> Yes, we pass "hda=615,4,17" to the IDE driver. 
> 
> Any suggestions of things to try?

First of all, what format is the data on the drives? ext2 or fat?

What mfm card are you using? I assume it is an isa card.  (I have never 
heard of a pci mfm card.)

If this is a one time thing, you might try tracking down an older version 
of Linux. (One with XT drive support.)

If you can't find one, contact me off-line.  I have versions going back to 
the Yggdrasil beta.  An old version of Slackware should work.



