Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSKNXNq>; Thu, 14 Nov 2002 18:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbSKNXNq>; Thu, 14 Nov 2002 18:13:46 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:38096 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S261854AbSKNXNp>; Thu, 14 Nov 2002 18:13:45 -0500
Date: Thu, 14 Nov 2002 16:17:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Have split-include take another argument
Message-ID: <20021114231721.GB608@opus.bloom.county>
References: <20021111170604.GA658@opus.bloom.county> <Pine.LNX.4.33.0211120917060.4022-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0211120917060.4022-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 03:01:18PM -0600, Kai Germaschewski wrote:
> On Mon, 11 Nov 2002, Tom Rini wrote:
> 
> > Hello.  The following patch makes split-include take another argument,
> > which is the prefix of what is being split up.  This is needed since I'm
> > working on a system which will allow for various params in the kernel to
> > be tweaked at compile-time, without offering numerous CONFIG options
> > (see http://marc.theaimsgroup.com/?l=linux-kernel&m=103669658505842&w=2).
> > I'm sending this out for two reasons.  First, does anyone see any
> > problems with the patch itself?  Second, Kai, would you be willing to
> > apply this patch now, or would should I wait until the system is ready?
> 
> Hmmh, I think I'd rather like to wait for the rest of the patch to see 
> what its actual purpose is. If at all possible, I'd like to avoid 
> introducing further hacks like this into kbuild, but that's more easily 
> discussed when I can see what you're trying to achieve.

Okay.  I hope to have another version of the patch out soon, and with a
few more kbuild questions once I convince myself that most of it works
(Adding in something similar to the CONFIG tweaking done by fixdep, but
with no real convinient way to see if the user changed something or
not).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
