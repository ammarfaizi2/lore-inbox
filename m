Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287997AbSABVBs>; Wed, 2 Jan 2002 16:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287967AbSABVAG>; Wed, 2 Jan 2002 16:00:06 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:32131
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287957AbSABU74>; Wed, 2 Jan 2002 15:59:56 -0500
Date: Wed, 2 Jan 2002 15:46:33 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102154633.A15671@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102151539.A14925@thyrsus.com> <E16LsU0-0005RB-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16LsU0-0005RB-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 02, 2002 at 08:59:32PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> You can make an educated guess. However it is at best an educated guess.
> The DMI tables will tell you what PCI and ISA slots are present (but
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> tend to be unreliable on older boxes).  You can also look for an ISA bridge
> in lspci as a second source of information.

That sounds like it might be what I'm after.  My goal is to be able to probe 
the machine and set ISA_CARDS based on the probe.  What's a DMI table and
how can I query it for the presence of ISA slots?

What I want to do with this is make ISA-card questions invisible on modern
PCI-only motherboards.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The men and women who founded our country knew, by experience, that there
are times when the free person's answer to oppressive government has to be
delivered with a bullet.  Thus, the right to bear arms is not just *a*
freedom; it's the mother of all freedoms.  Don't let them disarm you!
