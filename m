Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbSKNWEV>; Thu, 14 Nov 2002 17:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSKNWEV>; Thu, 14 Nov 2002 17:04:21 -0500
Received: from 159.221.vbnet.net ([205.140.159.221]:63104 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265306AbSKNWET>; Thu, 14 Nov 2002 17:04:19 -0500
Date: Thu, 14 Nov 2002 15:01:18 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@localhost.localdomain>
To: Tom Rini <trini@kernel.crashing.org>
cc: <kbuild-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Have split-include take another argument
In-Reply-To: <20021111170604.GA658@opus.bloom.county>
Message-ID: <Pine.LNX.4.33.0211120917060.4022-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2002, Tom Rini wrote:

> Hello.  The following patch makes split-include take another argument,
> which is the prefix of what is being split up.  This is needed since I'm
> working on a system which will allow for various params in the kernel to
> be tweaked at compile-time, without offering numerous CONFIG options
> (see http://marc.theaimsgroup.com/?l=linux-kernel&m=103669658505842&w=2).
> I'm sending this out for two reasons.  First, does anyone see any
> problems with the patch itself?  Second, Kai, would you be willing to
> apply this patch now, or would should I wait until the system is ready?

Hmmh, I think I'd rather like to wait for the rest of the patch to see 
what its actual purpose is. If at all possible, I'd like to avoid 
introducing further hacks like this into kbuild, but that's more easily 
discussed when I can see what you're trying to achieve.

--Kai



