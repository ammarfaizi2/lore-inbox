Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbTBLSf6>; Wed, 12 Feb 2003 13:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267454AbTBLSf5>; Wed, 12 Feb 2003 13:35:57 -0500
Received: from poup.poupinou.org ([195.101.94.96]:16429 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S267446AbTBLSf4>; Wed, 12 Feb 2003 13:35:56 -0500
Date: Wed, 12 Feb 2003 19:45:37 +0100
To: Shawn Starr <spstarr@sh0n.net>
Cc: Dave Jones <davej@codemonkey.org.uk>, Adam Belay <ambx1@neo.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.20][2.5.60] /proc/interrupts comparsion - two irqs for i8042?
Message-ID: <20030212184536.GD25632@poup.poupinou.org>
References: <20030212155506.GA13038@codemonkey.org.uk> <Pine.LNX.4.44.0302121114150.211-100000@coredump.sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302121114150.211-100000@coredump.sh0n.net>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 11:14:40AM -0500, Shawn Starr wrote:
> 
> Right but, why does this *not* show up in 2.4? IRQ 12 is free in 2.4 but
> not in 2.5 *with* PS/2 mouse enabled?!

Because this interrupt is only requested when /dev/psaux is opened in 2.4.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
