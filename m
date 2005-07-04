Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVGDShE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVGDShE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 14:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVGDShE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 14:37:04 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:11490 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261433AbVGDSgt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 14:36:49 -0400
Date: Mon, 4 Jul 2005 11:36:49 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
cc: Jens Axboe <axboe@suse.de>, Shawn Starr <shawn.starr@rogers.com>,
       Lenz Grimmer <lenz@grimmer.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up
In-Reply-To: <42C970D1.3090609@linuxwireless.org>
Message-ID: <Pine.LNX.4.63.0507041131390.26084@twinlark.arctic.org>
References: <20050704061713.GA1444@suse.de> <20050704142723.2202.qmail@web88009.mail.re2.yahoo.com>
 <20050704144634.GQ1444@suse.de> <42C970D1.3090609@linuxwireless.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2005, Alejandro Bonilla wrote:

>    Do you think that the kernel will STOP, HOLD and park the head in less than
> a second? OR on the time we need?

this is why the windows driver uses heuristics to decide when the laptop 
is possibly unstable and *may* fall soon... because it takes something 
like 700ms to actually park.  (a url floated by with the whitepaper-level 
details at some point.)

btw -- my usual box is a t42p running winxp, and i disable the parking 
code... whatever my normal usage is tends to trigger the parking 
heuristics too readily.  it's a cool idea, but i'm skeptical of its 
real-world value.

as for other details it's trivial to lock the daemon in memory and run it 
at nice -4 to get a head start on parking even when at 100% cpu and under 
memory load.

-dean
