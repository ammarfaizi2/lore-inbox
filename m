Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266908AbSL3LWQ>; Mon, 30 Dec 2002 06:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266927AbSL3LWQ>; Mon, 30 Dec 2002 06:22:16 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:59843 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266908AbSL3LWO>;
	Mon, 30 Dec 2002 06:22:14 -0500
Date: Mon, 30 Dec 2002 11:29:11 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Ville Herva <vherva@twilight.cs.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021230112911.GB11633@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
References: <200212090830.gB98USW05593@flux.loup.net> <at2l1t$g5n$1@penguin.transmeta.com> <20021209193649.GC10316@suse.de> <at2rv7$fkr$1@cesium.transmeta.com> <20021228203706.GD1258@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021228203706.GD1258@niksula.cs.hut.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 10:37:06PM +0200, Ville Herva wrote:

 > > SYSCALL is AMD.  SYSENTER is Intel, and is likely to be significantly
 > Now that Linus has killed the dragon and everybody seems happy with the
 > shiny new SYSENTER code, let just add one more stupid question to this
 > thread: has anyone made benchmarks on SYSCALL/SYSENTER/INT80 on Athlon? Is
 > SYSCALL worth doing separately for Athlon (and perhaps Hammer/32-bit mode)?

Its something I wondered about too. Even if it isn't a win for K7,
it's possible that the K6 family may benefit from SYSCALL support.
Maybe even the K5 if it was around that early ? (too lazy to check pdf's)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
