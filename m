Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbTBCCAr>; Sun, 2 Feb 2003 21:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbTBCCAr>; Sun, 2 Feb 2003 21:00:47 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:29059 "EHLO
	yeti.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id <S265670AbTBCCAq>; Sun, 2 Feb 2003 21:00:46 -0500
Date: Mon, 3 Feb 2003 13:09:57 +1100
From: CaT <cat@zip.com.au>
To: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Possible PnP BIOS GPF Solution for Sony VAIO and other laptops
Message-ID: <20030203020957.GE847@zip.com.au>
References: <20030202203702.GA23248@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030202203702.GA23248@neo.rr.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02, 2003 at 08:37:02PM +0000, Adam Belay wrote:
> The PnP BIOS may be wandering into segement 0x40.  If that is the case,
> this patch should fix the problem.  I do not have a buggy system so I
> cannot test this patch but I'd be intersted to hear the results.  If you
> have a system that has caused pnpbios problems in the past, I recommend
> you try this patch.  If it works, the system will not panic on startup.
> This patch is against 2.5.59 and separate from my other recent patches.

This boots fine here. Then again 2.5.59 booted fine aswell. :) I also
don't get any oopses from reading /proc/bus/pnp stuff as I did before
when I first reported issues. As with the bootup, I also don't get these
issues with 2.5.59. (ie 2.5.59 works fine with or without this patch).

Sorry for not getting back to you earlier btw... I lost almost a
fortnights worth of email and yours was amongst them. :/

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to         kill my dad."
        - George W. Bush Jr, 'President' of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)

