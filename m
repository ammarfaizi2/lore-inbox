Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265622AbUA0ArQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265627AbUA0ArQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:47:16 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:45968 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265622AbUA0AqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:46:12 -0500
Date: Mon, 26 Jan 2004 19:31:18 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.2-rc in BK: Oops loading parport_pc.
Message-ID: <20040126193117.GB7280@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Matthias Andree <matthias.andree@gmx.de>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040125115129.GA10387@merlin.emma.line.org> <20040125151454.70b5011e.akpm@osdl.org> <20040126010832.GA5462@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040126010832.GA5462@merlin.emma.line.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 02:08:32AM +0100, Matthias Andree wrote:
> On Sun, 25 Jan 2004, Andrew Morton wrote:
> 
> > Matthias Andree <matthias.andree@gmx.de> wrote:
> > >
> > >  Loading the parport_pc modules crashes in 2.6.2-rc; I have recently done
> > >  a "bk pull" and enabled some PNP options, among them ISA PNP.
> > 
> > Often this is because some other, unrelated module left things registered
> > after it was removed.  Or otherwise wrecked shared data structures.
> 
> The breakage is somehow related to CONFIG_PNP. I set that option to N,
> ran "make oldconfig ; make", installed the kernel, rebooted, problem
> gone.
> 
> -- 
> Matthias Andree

Are you using any modules other than parport_pc?  Have you unloaded them
before loading parport_pc?

Thanks,
Adam

