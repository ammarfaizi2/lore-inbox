Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbTBKUXQ>; Tue, 11 Feb 2003 15:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbTBKUXQ>; Tue, 11 Feb 2003 15:23:16 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:31141 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S266041AbTBKUXN>;
	Tue, 11 Feb 2003 15:23:13 -0500
Date: Tue, 11 Feb 2003 21:32:34 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: "Bryan O'Sullivan" <bos@serpentine.com>
cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, tbm@a2000.nu,
       peter@chubb.wattle.id.au
Subject: Re:2TB+ fs ext3 (was fsck out of memory)
In-Reply-To: <1044993857.6640.7.camel@plokta.s8.com>
Message-ID: <Pine.LNX.4.53.0302112127540.24931@ddx.a2000.nu>
References: <Pine.LNX.4.53.0302071555110.718@ddx.a2000.nu> 
 <Pine.LNX.4.53.0302071800200.1306@ddx.a2000.nu>  <20030207102858.P18636@schatzie.adilger.int>
  <Pine.LNX.4.53.0302090953440.1039@ddx.a2000.nu> 
 <1044917060.11838.108.camel@sisko.scot.redhat.com> 
 <Pine.LNX.4.53.0302111410350.13269@ddx.a2000.nu>  <1044973982.1980.29.camel@sisko.scot.redhat.com>
 <1044993857.6640.7.camel@plokta.s8.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2003, Bryan O'Sullivan wrote:

> Ugh, that stuff is ancient.
>
> Peter Chubb has a backport of his (very thorough) 2.5 patch to support
> large block devices on 32-bit platforms, against much newer kernels
> (e.g. 2.4.20) than Ben's stuff.  His site seems to be down, but you
> should be able to get it from somewhere under
> http://www.gelato.unsw.edu.au/~peterc/
correct link : http://www.gelato.unsw.edu.au/patches-index.html
(but down)

i used this patch, but i got this comment :

> Well, that's the most likely candidate, because it's the least tested
> component.  Are you using Ben LaHaise's LBD fixes for the md devices?
> Without those, md and lvm are not LBD-safe.

makes me wonder if i need another patch besides the 'Peter Chubb patch'
when using md raid ?

> I haven't used Peter's patch, but a similar patch, developed
> independently, definitely allows ext3 filesystems of up to 8TB in size
> to work fine on x86, under 2.4.

look at my other posts, i can't create/work with a 2348 Gigabyte /dev/md0
