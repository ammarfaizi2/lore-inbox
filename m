Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUG2UPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUG2UPD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 16:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbUG2UPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:15:03 -0400
Received: from users.linvision.com ([62.58.92.114]:57270 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S265195AbUG2UO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:14:59 -0400
Date: Thu, 29 Jul 2004 22:14:58 +0200
From: Rogier Wolff <Rogier@wolff.net>
To: linux-kernel@vger.kernel.org
Subject: OK, anybody have any hints and tips to get an MFM drive working again?
Message-ID: <20040729201458.GA19252@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We need to recover some data off an old MFM drive. We've got a bunch
of those cards, we've got a bunch of drives to experment with, but 
once we get things working we'll recover some 2x20Mb of data off two
20Mb drives....

We've tried the modern IDE driver, and the 2.4.20 one, and the "old
hd only" driver. 

Going "retro": Compiling 2.0.39 gives me: "bus error" while doing 
make dep. 

I THINK we have a couple of those cards that don't have any 
interrupts. Would Linux be able to work with those?

Yes, we pass "hda=615,4,17" to the IDE driver. 

Any suggestions of things to try?

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
