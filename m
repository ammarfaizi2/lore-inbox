Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289199AbSAGN1B>; Mon, 7 Jan 2002 08:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289190AbSAGN0h>; Mon, 7 Jan 2002 08:26:37 -0500
Received: from ns.suse.de ([213.95.15.193]:36366 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289207AbSAGNZk>;
	Mon, 7 Jan 2002 08:25:40 -0500
Date: Mon, 7 Jan 2002 14:25:39 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch?: linux-2.5.2-pre9/drivers/block/ll_rw_blk.c blk_rq_map_sg
 simplification
In-Reply-To: <200201071323.FAA04244@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.33.0201071425140.14473-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Adam J. Richter wrote:

> 	The conditional is one level deep (it's just a list of
> "and" conjunctions) and has a single conceptual meaning, "are
> the segments joinable?"  For what it's worth, I really could not
> understand the old version until I rewrote it without gotos.

whitespace == a good thing.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

