Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264617AbSKSIOA>; Tue, 19 Nov 2002 03:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbSKSIOA>; Tue, 19 Nov 2002 03:14:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28688 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264617AbSKSIN7>; Tue, 19 Nov 2002 03:13:59 -0500
Date: Tue, 19 Nov 2002 00:16:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: bert hubert <ahu@ds9a.nl>
cc: Dax Kelson <dax@gurulabs.com>, "Grover, Andrew" <andrew.grover@intel.com>,
       <pavel@ucw.cz>, <vojtech@suse.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BK current compile failure
In-Reply-To: <20021119075614.GA25237@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0211190012240.24793-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Nov 2002, bert hubert wrote:
> 
> I know Ben (I think?) has a .config that currently compiles with 2.5 but
> also includes almost everything that is working right now and so quickly
> exposes stuff that breaks.

On the other hand, we do need to start fixing the odd stuff too, not just
keep one "wide" config working. Usually the "make an arbitrary
'randconfig' always work" phase comes fairly late in the game, and I'm not
saying we should even try to aim for that right now, but on the other hand
we should probably clean up some of the unnecessary confusion with config
options where the problem sometimes simply is that the Kconfig files don't
contain the right dependencies, for example.

Yeah, considering how 2.5.48 doesn't compile with modules disabled, I'm 
throwing stones in glass houses, but let's try to fix the stupid ones so 
that people can see what the real problems are..

			Linus

