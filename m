Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264125AbTCXGlf>; Mon, 24 Mar 2003 01:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264126AbTCXGlf>; Mon, 24 Mar 2003 01:41:35 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:5649 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264125AbTCXGle>; Mon, 24 Mar 2003 01:41:34 -0500
Date: Mon, 24 Mar 2003 06:52:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Jeff Garzik <jgarzik@pobox.com>,
       James Bourne <jbourne@mtroyal.ab.ca>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Alan Cox <alan@redhat.com>, Stephan von Krawczynski <skraw@ithnet.com>,
       szepe@pinerecords.com, arjanv@redhat.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030324065224.A15528@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"J.A. Magallon" <jamagallon@able.es>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	James Bourne <jbourne@mtroyal.ab.ca>, linux-kernel@vger.kernel.org,
	Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
	Alan Cox <alan@redhat.com>,
	Stephan von Krawczynski <skraw@ithnet.com>, szepe@pinerecords.com,
	arjanv@redhat.com, Pavel Machek <pavel@ucw.cz>
References: <1048450211.1486.19.camel@phantasy.awol.org> <402760000.1048451441@[10.10.2.4]> <20030323203628.GA16025@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.51.0303231410250.17155@skuld.mtroyal.ab.ca> <920000.1048456387@[10.10.2.4]> <3E7E335C.2050509@pobox.com> <1240000.1048460079@[10.10.2.4]> <3E7E4486.8080302@pobox.com> <6850000.1048463137@[10.10.2.4]> <20030324000713.GA17795@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030324000713.GA17795@werewolf.able.es>; from jamagallon@able.es on Mon, Mar 24, 2003 at 01:07:13AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 01:07:13AM +0100, J.A. Magallon wrote:
> You will never get distros to follow that. A 'featured-kernel-for-distro'...
> Just take RH and SuSE (correct me if I'm wrong...)
> RH ships -ac. SuSE ships -aa. At least both (-ac and -aa) have O(1) scheduler
> now. -ac ships rmap, -aa ships -aa (;)). That means O(1) goes in your kernel,
> but how about the VM subsystem ? 

Mainline needs VM updates and as the -aa VM is the actual fixes for the
2.4.10+ VM it needs to be merged (at least partially).  It's sad that this
happened after akpm and other spent lots of time on splitting up and
documenting it.

