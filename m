Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268392AbTAMWl5>; Mon, 13 Jan 2003 17:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268386AbTAMWl5>; Mon, 13 Jan 2003 17:41:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52234 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268392AbTAMWlz>; Mon, 13 Jan 2003 17:41:55 -0500
Date: Mon, 13 Jan 2003 14:48:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Adam Belay <ambx1@neo.rr.com>
cc: Jaroslav Kysela <perex@suse.cz>, Greg KH <greg@kroah.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>, Shawn Starr <spstarr@sh0n.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnP update - drivers
In-Reply-To: <20030113173906.GA605@neo.rr.com>
Message-ID: <Pine.LNX.4.44.0301131446380.15429-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Jan 2003, Adam Belay wrote:
> 
> I'm now unhappy with the current pnp code and will most likely revert all pnp
> changes between 2.5.56 and 2.5.57 to avoid a merging nightmare.  I will then
> carefully remerge what I feel is acceptable.

I will _not_ accept just stupid reverts, if that means that a device 
driver is not available for people to test with.

We do not break drivers like that, and the reason you have clashes with 
other people is that so many drivers ended up being broken for too long. 

Feel free to revert the changes one by one _as_they_get_fixed_. But don't 
even try to send me a patch that reverts things to a broken state. The PnP 
changes have been painful enough as-is.

		Linus

