Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261706AbTCQCQL>; Sun, 16 Mar 2003 21:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261707AbTCQCQL>; Sun, 16 Mar 2003 21:16:11 -0500
Received: from holomorphy.com ([66.224.33.161]:16856 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261706AbTCQCQK>;
	Sun, 16 Mar 2003 21:16:10 -0500
Date: Sun, 16 Mar 2003 18:26:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Gregory K. Ruiz-Ade" <gregory@castandcrew.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 instability on bigmem systems?
Message-ID: <20030317022646.GN20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Gregory K. Ruiz-Ade" <gregory@castandcrew.com>,
	linux-kernel@vger.kernel.org
References: <200303131627.22572.gregory@castandcrew.com> <200303140931.15541.gregory@castandcrew.com> <20030314200857.GL20188@holomorphy.com> <200303161815.11973.gregory@castandcrew.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303161815.11973.gregory@castandcrew.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 16, 2003 at 06:15:11PM -0800, Gregory K. Ruiz-Ade wrote:
> Okay, I tried to load the system a bit and stress out the disk I/O, running 
> a couple finds across the whole system (find | xargs stat, find | xargs cat 
> > /dev/null, a couple other things) after sucking up free memory by catting 
> our database disk files to /dev/null.  I also had a 'make -j5 clean 
> oldconfig dep bzImage modules' running to try to drive the load up a bit, 
> too.
> I've got snapshots of meminfo, slabinfo, and output from 'ps auxfww' at:
> http://castandcrew.com/~gregory/lkmlstuff/burpr/2.4.20/loadtest/
> It only really starts getting interesting after 20030316.1725, when I 
> started the kernel build.  I have a very simple shell script that basically 
> does nothing other than "make clean oldconfig dep && make -j5 bzImage && 
> make -j5 modules".  I ran that a couple times in the sources for Red Hat's 
> 2.4.9-e.12 kernel sources.
> Surprisingly I wasn't able to grind down the system like I expected.  Not 
> sure why it's behaving so wonderfully today.

If it didn't behave badly then it won't help to look at the stats.


-- wli
