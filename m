Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271748AbRICQsC>; Mon, 3 Sep 2001 12:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271753AbRICQrw>; Mon, 3 Sep 2001 12:47:52 -0400
Received: from tierra.stl.es ([195.235.83.3]:17985 "EHLO tierra.stl.es")
	by vger.kernel.org with ESMTP id <S271748AbRICQrm>;
	Mon, 3 Sep 2001 12:47:42 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Transparent proxy support in 2.4 - revisited
In-Reply-To: <20010903161621.A14859@leeor.math.technion.ac.il>
	<20010607170825.A18760@leeor.math.technion.ac.il>
	<20010608014443.A28407@saw.sw.com.sg>
	<20010903131240.A9791@leeor.math.technion.ac.il>
	<20010903144442.A32332@castle.nmd.msu.ru>
	<20010903161621.A14859@leeor.math.technion.ac.il>
	<20010903175544.A1340@castle.nmd.msu.ru>
From: Julio Sanchez Fernandez <j_sanchez@stl.es>
Date: 03 Sep 2001 18:43:07 +0200
In-Reply-To: Andrey Savochkin's message of "Mon, 3 Sep 2001 17:55:44 +0400"
Message-ID: <m21ylow7hg.fsf@j-sanchez-p.stl.es>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin <saw@saw.sw.com.sg> writes:

> It had been broken in 2.2 for months and nobody repaired it => nobody needed
> it.  I don't know, whether it works now or not.

Broken?  It worked for me on all kernels I tried from RH, I currently
run it on 2.2.19.

> How are you going to determine whether the packet is destined to you or two
> the real server?
> That's the main question.

Maybe follow the method used by NAT now?  I mean, I presume no one
wants to go back to the old implementation...

> If the module always rewrites the destination IP address, and it can't be
> turned off, it's certainly a misfeature.
> Make it conditional, or just make a quick hack for yourself, or copy the
> existing redirect module, fix it and use the new module.

Well, that's another one to get used to, the old code made the output
from netstat or lsof extremely informative, something that is pretty
much lost now in 2.4.x.  Right?

Julio
