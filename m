Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266676AbSKZThL>; Tue, 26 Nov 2002 14:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266678AbSKZTgm>; Tue, 26 Nov 2002 14:36:42 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:18642 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266676AbSKZTgh>;
	Tue, 26 Nov 2002 14:36:37 -0500
Date: Tue, 26 Nov 2002 19:41:29 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, alan@redhat.com
Subject: Re: A new Athlon 'bug'.
Message-ID: <20021126194129.GA24152@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com, alan@redhat.com
References: <200211211556.gALFunG3014402@noodles.internal> <20021125213447.GB12236@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021125213447.GB12236@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 10:34:47PM +0100, Pavel Machek wrote:

 > > Very recent Athlons (Model 8 stepping 1 and above) (XPs/MPs and mobiles)
 > > have an interesting problem.  Certain bits in the CLK_CTL register need
 > > to be programmed differently to those in earlier models. The problem arises
 > > when people plug these new CPUs into boards running BIOSes that are unaware
 > > of this fact.
 > What happens when bit is programed wrongly?

The documentation I have says nothing other than "...platforms are more
robust..." with the fix. It's purely a reliability thing, but as it's
fiddling with the CPU clock, it's possible that it may *slightly*
affect performance too.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
