Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132853AbRDPGGl>; Mon, 16 Apr 2001 02:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132854AbRDPGGc>; Mon, 16 Apr 2001 02:06:32 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:43018 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132853AbRDPGGT>;
	Mon, 16 Apr 2001 02:06:19 -0400
Date: Mon, 16 Apr 2001 02:07:34 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.1.2 is available
Message-ID: <20010416020734.A9324@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010415143316.A6115@thyrsus.com> <5.0.2.1.2.20010416005604.00ac8ec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.0.2.1.2.20010416005604.00ac8ec0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Mon, Apr 16, 2001 at 12:58:03AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk>:
> When .config is missing and error is emitted when running make menuconfig 
> (or any other I guess) for the first time. Should this be the case? It's 
> ignored so ok but still would be nice not to have an error.

Yes, that is the expected behavior.  It will go away eventually; this is
part of the transition while the old .config format is still valid.
 
> In ttyconfig: If type 'a' then enter then 'a' then enter then 'v' then 
> enter it crashes out... Might be specific to where you are at the time. 
> Sorry don't remember.

Just the (undocumented) v command would have done it.  It was expecting a 
numeric debug level argument.  I've fixed it to treat "v' alone as a command
to increment the debug level.
 
> Good performance going up/down in menuconfig now. Even on my Pentium 133S! 
> Excellent work! (fastmode on)

We aim to please...
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

No matter how one approaches the figures, one is forced to the rather
startling conclusion that the use of firearms in crime was very much
less when there were no controls of any sort and when anyone,
convicted criminal or lunatic, could buy any type of firearm without
restriction.  Half a century of strict controls on pistols has ended,
perversely, with a far greater use of this weapon in crime than ever
before.
        -- Colin Greenwood, in the study "Firearms Control", 1972
