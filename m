Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTIDBcZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 21:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264466AbTIDBcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 21:32:25 -0400
Received: from holomorphy.com ([66.224.33.161]:63371 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264464AbTIDBcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 21:32:23 -0400
Date: Wed, 3 Sep 2003 18:32:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Larry McVoy <lm@work.bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <20030904013253.GB4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030903180547.GD5769@work.bitmover.com> <20030903181550.GR4306@holomorphy.com> <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk> <20030903194658.GC1715@holomorphy.com> <105370000.1062622139@flay> <20030903212119.GX4306@holomorphy.com> <115070000.1062624541@flay> <20030903215135.GY4306@holomorphy.com> <116940000.1062625566@flay> <20030904010653.GD5227@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904010653.GD5227@work.bitmover.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 06:06:53PM -0700, Larry McVoy wrote:
> Here's a thought.  Maybe the next kernel summit needs to have a CC cluster
> BOF or whatever.  I'd be happy to show up, describe what it is that I see
> and have you all try and poke holes in it.  If the net result was that you
> walked away with the same picture in your head that I have that would be
> cool.  Heck, I'll sponser it and buy beer and food if you like.

It'd be nice if there were a prototype or something around to at least
get a feel for whether it's worthwhile and how it behaves.

Most of the individual mechanisms have other uses ranging from playing
the good citizen under a hypervisor to just plain old filesharing, so
it should be vaguely possible to get a couple kernels talking and
farting around without much more than 1-2 P-Y's for bootstrapping bits
and some unspecified amount of pain for missing pieces of the above.

Unfortunately, this means
(a) the box needs a hypervisor (or equivalent in native nomenclature)
(b) substantial outlay of kernel hacking time (who's doing this?)

I'm vaguely attached to the idea of there being _something_ to assess,
otherwise it's difficult to ground the discussions in evidence, though
worse comes to worse, we can break down to plotting and scheming again.


-- wli
