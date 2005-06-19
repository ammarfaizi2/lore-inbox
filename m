Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVFSOHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVFSOHo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 10:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVFSOHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 10:07:43 -0400
Received: from mail.linicks.net ([217.204.244.146]:49675 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261172AbVFSOHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 10:07:38 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2 errors in 2.6.12
Date: Sun, 19 Jun 2005 15:07:35 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506191507.35831.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to myself...

> Here is a page with the ID and chipsets of the cards:
> 
> http://www.digit-life.com/articles/livetolive51/
> 
> I am going to attempt to add my card into emu10k1_main.c to get it set
> right:
> 
> 0 [Unknown        ]: EMU10K1 - SB Live [Unknown]
>                      SB Live [Unknown] (rev.7, serial:0x80611102) at
>                      0xe000,
> irq 5
> 
> From that 'livetolive51' page I am told I have:
> SB0060 - SBlive! Value (PCI\VEN_1102&DEV_0002&SUBSYS_80611102)

This worked fine, but fishing around, I see 'new' cards ID's are added all the 
time:

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c?rev=1.58&view=log

so eventually the [UKNOWN] bit will disappear and alsamixer settings will 
remain between different version kernels (2.6.1x[.x]) then.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
