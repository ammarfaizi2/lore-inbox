Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWGQPv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWGQPv4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWGQPv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:51:56 -0400
Received: from mail.gmx.net ([213.165.64.21]:53429 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750862AbWGQPvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:51:55 -0400
X-Authenticated: #428038
Date: Mon, 17 Jul 2006 17:51:51 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Diego Calleja <diegocg@gmail.com>, arjan@infradead.org,
       caleb@calebgray.com, linux-kernel@vger.kernel.org
Subject: Re: Reiser4 Inclusion
Message-ID: <20060717155151.GD8276@merlin.emma.line.org>
Mail-Followup-To: Grzegorz Kulewski <kangur@polcom.net>,
	Diego Calleja <diegocg@gmail.com>, arjan@infradead.org,
	caleb@calebgray.com, linux-kernel@vger.kernel.org
References: <44BAFDB7.9050203@calebgray.com> <1153128374.3062.10.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net> <20060717160618.013ea282.diegocg@gmail.com> <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12-2006-07-14
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2006, Grzegorz Kulewski wrote:

> Keeping Reiser4 out of kernel is even worse (for those users, other users 
> that could test this filesystem, for Reiser4 developers and whole 
> comunity) than accepting it for a try period with a big fat warning that 
> it my be removed if Namesys abandons futher fixing of it (after some time 
> to let user migrate).

And what are you going to do in the meanwhile, if reiser4 should be
fundamentally broken because namesys decided reiser11 was so much cooler
to work on, as has happened with 3.6 which still cannot handle hash
collisions properly?

> And any arguments like "if Reiser4 is not in the kernel then people will 
> not use and depend on it" are fundamentally flawed IMHO. Everything bad 
> that could happen with Reiser4 in the kernel can happen with Reiser4 out 
> of it.

Right, but accepting it into baseline is seen as "endorsement" by major
parts of the audience, and this is in fact what they like to see.

> It may look like some kernel developers are trying hard not to take 
> responsibility for Reiser4 saying that there is very huge difference 
> between selecting highly experimental kernel feature that is marked so and 
> patching the kernel with it. Sorry but I think there is very little 
> difference. And that little difference is only hurting users that want to 
> try and test something new.

Any why can those users not download and apply a patch, try it and
report back to Namesys?

-- 
Matthias Andree
