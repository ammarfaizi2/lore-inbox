Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272402AbTHEDEn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 23:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272401AbTHEDEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 23:04:42 -0400
Received: from almesberger.net ([63.105.73.239]:52998 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S272390AbTHEDEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 23:04:38 -0400
Date: Tue, 5 Aug 2003 00:04:22 -0300
From: Werner Almesberger <werner@almesberger.net>
To: David Lang <david.lang@digitalinsight.com>
Cc: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TOE brain dump
Message-ID: <20030805000422.S5798@almesberger.net>
References: <20030804223800.P5798@almesberger.net> <Pine.LNX.4.44.0308041841190.7534-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308041841190.7534-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Mon, Aug 04, 2003 at 06:46:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> exactly, Alan is saying that the hardware optimizations aren't nessasary.

Eventually, you'll want them, and if it's only to lower the
chip or pin count.

> putting an Opteron on a NIC card just to match the other processors in
> your system seems like a huge amount of overkill. you aren't going to have
> nearly the same access to memory so that processor will be crippled, but
> stil cost full price

You might be able to get them for free ;-) Just pick the
rejects where the FPU or such doesn't quite work. Call it
amd64sx :-)

But even if you get regular CPUs, they're not *that*
expensive. Particularly not for a first generation design.

> (and then some, remember you have to supply the thing
> with power and cool it)

Yes, this, chip count, and chip surface are what make me feel
queasy when thinking of somebody using something as powerful
as an amd64.

> as long as tools are written that have the same command line semantics the
> rest of the complexity can be hidden.

You want to be API and probably even ABI-compatible, so that
user-space demons (routing, management, etc.) work, too.

> and even this isn't strictly
> nessasary, these are special purpose cards and a special procedure for
> configuring them isn't unreasonable.

I'd think thrice before buying a card that requires me to
change my entire network management system - and change it
again, if I ever decide to switch brands, or if the next
generation of that special NIC gets a little more special.

> I'm saying treat the one machine with 10 of these specialty NIC's in it as
> a 11 machine cluster, one machne running your server software and 10
> others running your networking.

You can probably afford rather fancy TOE hardware for the
price of ten cluster nodes, a high-speed LAN to connect
your cluster, and a switch that connects the high-speed
link to the ten not-quite-so-high-speed links.

Likewise for power, cooling, and space.

And that's still assuming you can actually distribute all
this.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
