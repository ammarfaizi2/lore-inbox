Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263379AbRFKDmS>; Sun, 10 Jun 2001 23:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263381AbRFKDmI>; Sun, 10 Jun 2001 23:42:08 -0400
Received: from dryline-fw.yyz.somanetworks.com ([216.126.67.45]:22552 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S263379AbRFKDmC>; Sun, 10 Jun 2001 23:42:02 -0400
Date: Sun, 10 Jun 2001 23:41:54 -0400 (EDT)
From: Scott Murray <scottm@somanetworks.com>
To: John Fremlin <vii@users.sourceforge.net>
cc: <perex@suse.cz>, Robin Cull <kernel-list@phaderunner.demon.co.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 isapnp - wrong set of resources chosen
In-Reply-To: <m23d97aod9.fsf@boreas.yi.org.>
Message-ID: <Pine.LNX.4.30.0106102332170.18866-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jun 2001, John Fremlin wrote:

> Hi!
>
> Robin Cull and I have OPL3-SA2 isapnp cards. Sometimes we get assigned
> the wrong resource set. These cards do not take kindly to Alternate
> resources 0:1 Priority acceptable, in fact they are completely broke,
> so it is important to us that they get their first choice ;-)
>
> The trouble is that isapnp auto conf does not always take the first
> choice, even when it is available! This happens to me everytime I
> unload and reload the opl3sa2 module, but can also be seen after
> unloading the module by doing
[snip]

Hmmm, interesting.  I'd noticed this when testing the ISA PnP changes
to the driver, but since the config the in-kernel PnP code was picking
worked on the two machines I tried, I thought it was a relatively
harmless glitch.  I had little success parsing the PnP driver myself
when I tried, and unfortunately I've little time for working in depth
on sound stuff at the moment.  I'm willing to test out any suggestions,
though.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
Work e-mail: scottm@somanetworks.com
Home e-mail: scott@spiteful.org

