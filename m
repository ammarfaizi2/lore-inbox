Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVH1SRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVH1SRM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 14:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVH1SRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 14:17:12 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:29459 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750738AbVH1SRL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 14:17:11 -0400
Date: Sun, 28 Aug 2005 20:17:06 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andreas Schwab <schwab@suse.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.6.13-rc7-git2 crashes on iBook
Message-Id: <20050828201706.07660a62.khali@linux-fr.org>
In-Reply-To: <jehdda2tqt.fsf@sykes.suse.de>
References: <jehdda2tqt.fsf@sykes.suse.de>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas, all,

> The last change to drivers/pci/setup-res.c (Ignore disabled ROM
> resources at setup) is breaking radeonfb on iBook G3 (with Radeon
> Mobility M6 LY). It crashes in pci_map_rom when called from
> radeonfb_map_ROM.  This is probably a dormant bug that was just
> uncovered by the change.

FWIW, it didn't seem to break my Sony Vaio PCG-GR214EP (x86 with Radeon
Mobility M6 LY as well.) So it must be machine-specific, not
chip-specific.

-- 
Jean Delvare
