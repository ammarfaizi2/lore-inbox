Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319018AbSHFIpK>; Tue, 6 Aug 2002 04:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319019AbSHFIpK>; Tue, 6 Aug 2002 04:45:10 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:18703 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S319018AbSHFIpH>;
	Tue, 6 Aug 2002 04:45:07 -0400
Date: Tue, 6 Aug 2002 10:48:40 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Robert Latham <robl@mcs.anl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tigon3: 2466 and bad performance at 32bits/33mhz ?
Message-ID: <20020806084840.GB32229@alpha.home.local>
References: <20020806053508.GJ25554@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020806053508.GJ25554@mcs.anl.gov>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 12:35:08AM -0500, Robert Latham wrote:
> The fast curve is with the 3c996B-T in the 64/66 slot.  It peaks out
> around 850 Mbps.  The slow curve is the same card in the 32/33 slot.
> It peaks around 180 Mbps.
[snip]
> So, am i looking at a hardware limitation?  driver quirk?  I'm open to
> any suggestions.  

on a 32/33 slot, with a quad fast ethernet card, I can reach 400 Mbps
on good hardware. The *theorical* bandwidth limit is 1.06 Gbps for
32 bits/33 Mhz. Of course, there's some overhead, but you would need 80%
overhead to get you numbers, not very likely...

Perhaps this slot is on another bus, perhaps the latency timer is too
low and the card receives small chunks at once, or perhaps this bus
is shared with another hungry device ?

Regards,
willy

