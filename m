Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267289AbTBNCxa>; Thu, 13 Feb 2003 21:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268160AbTBNCxa>; Thu, 13 Feb 2003 21:53:30 -0500
Received: from ool-4351594a.dyn.optonline.net ([67.81.89.74]:1286 "EHLO
	badula.org") by vger.kernel.org with ESMTP id <S267289AbTBNCx3>;
	Thu, 13 Feb 2003 21:53:29 -0500
Date: Thu, 13 Feb 2003 22:03:13 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [net drvr] starfire driver update for 2.5.60
In-Reply-To: <3E4C3AF7.1000203@pobox.com>
Message-ID: <Pine.LNX.4.44.0302132158160.3318-100000@moisil.badula.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003, Jeff Garzik wrote:

> Just to add, I think a lot of your patch is obviously useful, and needed.
> 
> Can you split it up into digestable chunks?

I can split it as:

-1.3.6+bugfixes (the patch I submitted to the Red Hat bugzilla)
-1.3.7 (VLAN support)
-1.3.9 (64-bit support)
-1.4.1 (NAPI support)

But I'd like to hear first if my previous mail addressed your concerns.  
BTW, if I didn't make it clear enough: that 4 slot reservation is an
optimization, not a workaround -- it would work correctly even without it,
but you'd get really sucky behavior with SG skbuffs.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

