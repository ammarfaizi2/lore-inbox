Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317639AbSGJV63>; Wed, 10 Jul 2002 17:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317640AbSGJV62>; Wed, 10 Jul 2002 17:58:28 -0400
Received: from pD952AE71.dip.t-dialin.net ([217.82.174.113]:6275 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317639AbSGJV62>; Wed, 10 Jul 2002 17:58:28 -0400
Date: Wed, 10 Jul 2002 16:01:08 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Andrew Morton <akpm@zip.com.au>
cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <3D2CA6E3.CB5BC420@zip.com.au>
Message-ID: <Pine.LNX.4.44.0207101559460.5067-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 10 Jul 2002, Andrew Morton wrote:
> That makes a ton of sense.
> 
> > But on the other hand, increasing HZ has perf/latency benefits, yes? Have
> > these been quantified?
> 
> Not that I'm aware of.  And I'd regard any such claims with some
> scepticism.
> 
> > I'd either like to see a HZ that has balanced
> > power/performance, or could we perhaps detect we are on a system that cares
> > about power (aka a laptop) and tweak its value at runtime?

Want a config option? Either int or bool (CONFIG_LOW_HZ). It's not too 
much effort.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

