Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287106AbSABWio>; Wed, 2 Jan 2002 17:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287143AbSABWi1>; Wed, 2 Jan 2002 17:38:27 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:64387
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287139AbSABWiO>; Wed, 2 Jan 2002 17:38:14 -0500
Date: Wed, 2 Jan 2002 17:24:48 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102172448.A18153@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102170833.A17655@thyrsus.com> <E16Lu2i-0005nd-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16Lu2i-0005nd-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 02, 2002 at 10:39:27PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> So you want the lowest possible priviledge level. Because if so thats
> setuid app not kernel space. Arguing about the same code in either kernel
> space verus setuid app space is garbage.

But you're thinking like a developer, not a user.  The right question
is which approach requires the lowest level of *user* privilege to get
the job done.  Comparing world-readable /proc files versus a setuid app,
the answer is obvious.  This sort of thing is exactly what /proc is *for*.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Non-cooperation with evil is as much a duty as cooperation with good.
	-- Mohandas Gandhi
