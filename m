Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270726AbTGPMpG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 08:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270729AbTGPMpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 08:45:06 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:23440
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S270726AbTGPMpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 08:45:04 -0400
Date: Wed, 16 Jul 2003 14:59:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Chris Mason <mason@suse.com>, lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030716125933.GF4978@dualathlon.random>
References: <20030714054918.GD843@suse.de> <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva> <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de> <20030714201637.GQ16313@dualathlon.random> <20030715052640.GY833@suse.de> <1058268126.3857.25.camel@dhcp22.swansea.linux.org.uk> <20030715112737.GQ833@suse.de> <20030716124355.GE4978@dualathlon.random> <20030716124656.GY833@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716124656.GY833@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 02:46:56PM +0200, Jens Axboe wrote:
> Well it's a combined problem. Threshold too high on dirty memory,
> someone doing a read well get stuck flushing out as well.

a pure read not. the write throttling should be per-process, then there
will be little risk.

Andrea
