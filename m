Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbTAJQWy>; Fri, 10 Jan 2003 11:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265355AbTAJQWy>; Fri, 10 Jan 2003 11:22:54 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:898 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265351AbTAJQWx>;
	Fri, 10 Jan 2003 11:22:53 -0500
Date: Fri, 10 Jan 2003 16:28:34 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030110162834.GB23375@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	William Lee Irwin III <wli@holomorphy.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030110161012.GD2041@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030110161012.GD2041@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 08:10:12AM -0800, William Lee Irwin III wrote:
 > Say, I've been having _smashing_ success with 2.5.x on the desktop and
 > on big fat highmem umpteen-way SMP (NUMA even!) boxen, and I was
 > wondering if you were considering 2.6.0-test* anytime soon.

There's still a boatload of drivers that don't compile,
a metric shitload of bits that never came over from 2.4 after
I stopped doing it circa 2.4.18, a lot of little 'trivial'
patches that got left by the wayside, and a load of 'strange' bits
that still need nailing down (personally, I have two boxes
that won't boot a 2.5 kernel currently (One was pnpbios related,
other needs more investigation), and another that falls on its
face after 10 minutes idle uptime. My p4-ht desktop box is the only one
that runs 2.5 without any problems.

I think we're a way off from a '2.6-test' phase personally,
but instigating a harder 'code freeze' would probably be a
good thing to do[1]

		Dave

[1] Exemption granted for the bits not yet brought forward
    of course.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
