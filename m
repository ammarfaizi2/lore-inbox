Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTHaOvD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 10:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbTHaOvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 10:51:03 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:24016
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261873AbTHaOvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 10:51:01 -0400
Date: Sun, 31 Aug 2003 16:51:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831145123.GT24409@dualathlon.random>
References: <20030831013928.GN24409@dualathlon.random> <Pine.LNX.4.44.0308311543050.993-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308311543050.993-100000@neptune.local>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 03:47:17PM +0200, Pascal Schmidt wrote:
> On Sun, 31 Aug 2003, Andrea Arcangeli wrote:
> 
> > This is what I use normally to limit my brother downloads, and it works
> > fine for me (though I don't often place calls through adsl myself, it's
> > basically useless since people only uses cellphones here, and last time
> > I chekced voip wasn't free for cellphones with my isp).
> > 
> > this is the script:
> 
> Mine is similar, though I use tc filters instead of firewalling
> rules (my machine is on 192.168.2.0/24, rest of the house is
> on 192.168.3.0/24) I'm using the imq device on a 2.2 kernel to
> have all traffic go through that device for shaping:

the main reason I choosen to mark the packets through netfilter is that
I don't find `tc` very intuitive (the most annoying thing is that it
misses a flush command), so it'll be quicker to add future tweaks this
way (like adding more ips or port/ip combinations into the "shaped"
channel)

thanks,
Andrea
