Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267940AbUHPUYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267940AbUHPUYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 16:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267941AbUHPUYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 16:24:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40345 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267940AbUHPUYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 16:24:36 -0400
Date: Mon, 16 Aug 2004 21:26:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Daniel Phillips <phillips@istop.com>,
       "Walker, Bruce J" <bruce.walker@hp.com>,
       Discussion of clustering software components including
	 GFS <linux-cluster@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       opengfs-devel@lists.sourceforge.net,
       opengfs-users@lists.sourceforge.net,
       opendlm-devel@lists.sourceforge.net
Subject: Re: [Linux-cluster] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
Message-ID: <20040816192602.GA467@openzaurus.ucw.cz>
References: <3689AF909D816446BA505D21F1461AE4C750E6@cacexc04.americas.cpqcorp.net> <200408011330.01848.phillips@istop.com> <410D2949.20503@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410D2949.20503@backtobasicsmgmt.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I wonder if device-mapper (slightly hacked) wouldn't be a better 
> >approach for 2.6+.
> 
> It appeared from the original posting that their "cluster-wide devfs" 
> actually supported all types of device nodes, not just block devices. 
> I don't know whether accessing a character device on another node 
> would ever be useful, but certainly using device-mapper wouldn't help 
> for that case.

Remote character devices seem extremely usefull to me...

mpg456 --device /dev/kitchen/dsp

cat /dev/roof/dsp > /dev/laptop/dsp

cat picture-to-scare-pigeons.raw > /dev/roof/fb0

X --device=/dev/livingroom/fb0

.... Okay, it will probably take a while until SSI cluster is the
right tool to network your home :-).

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

