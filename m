Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288434AbSADBGx>; Thu, 3 Jan 2002 20:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288438AbSADBGo>; Thu, 3 Jan 2002 20:06:44 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:52619
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288434AbSADBGa>; Thu, 3 Jan 2002 20:06:30 -0500
Date: Thu, 3 Jan 2002 19:52:07 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Joerg Schilling <schilling@fokus.gmd.de>, anderson@metrolink.com,
        hch@caldera.de, lsb-discuss@lists.linuxbase.org,
        lsb-spec@lists.linuxbase.org, linux-kernel@vger.kernel.org
Subject: Re: LSB1.1: /proc/cpuinfo
Message-ID: <20020103195207.A31252@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alexander Viro <viro@math.psu.edu>,
	Joerg Schilling <schilling@fokus.gmd.de>, anderson@metrolink.com,
	hch@caldera.de, lsb-discuss@lists.linuxbase.org,
	lsb-spec@lists.linuxbase.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020103190219.B27938@thyrsus.com> <Pine.GSO.4.21.0201031944320.23693-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0201031944320.23693-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Jan 03, 2002 at 07:56:51PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu>:
> It's more than just a name.
> 	a) granularity.  Current "all or nothing" policy in procfs has
> a lot of obvious problems.
> 	b) tree layout policy (lack thereof, to be precise).
> 	c) horribly bad layout of many, many files.  Any file exported by
> kernel should be treated as user-visible API.  As it is, common mentality
> is "it's a common dump; anything goes here".  Inconsistent across
> architectures for no good reason, inconsistent across kernel versions,
> just plain stupid, choke-full of buffer overruns...
> 
> Fixing these problems will _hurt_.  Badly.  We have to do it, but it
> won't be fast and it certainly won't happen overnight.

I'm willing to work on this.  Is there anywhere I can go to read up on 
current proposals before I start coding?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

When all government ...in little as in great things... shall be drawn to
Washington as the center of all power; it will render powerless the checks
provided of one government on another, and will become as venal and oppressive
as the government from which we separated."	-- Thomas Jefferson, 1821
