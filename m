Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264946AbSKSBGk>; Mon, 18 Nov 2002 20:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264976AbSKSBGk>; Mon, 18 Nov 2002 20:06:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28167 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264946AbSKSBGk>; Mon, 18 Nov 2002 20:06:40 -0500
Date: Mon, 18 Nov 2002 17:13:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: "Adam J. Richter" <adam@yggdrasil.com>, <gzp@myhost.mynet>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix devfs compile problems was Re: Linux v2.5.48
In-Reply-To: <20021119012021.A21171@wotan.suse.de>
Message-ID: <Pine.LNX.4.44.0211181713020.13535-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Nov 2002, Andi Kleen wrote:
> 
> If you want to make it 100% correct change the de->inode.[mac]time to
> struct timespec. If you just want it working the first patch is probably
> fine.

My BK tree already does the timespec thing, see bkbits.net (or the 
upcoming nightly snapshots)

		Linus

