Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130451AbRBRAGQ>; Sat, 17 Feb 2001 19:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131228AbRBRAGH>; Sat, 17 Feb 2001 19:06:07 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:59659 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130451AbRBRAF5>; Sat, 17 Feb 2001 19:05:57 -0500
Date: Sat, 17 Feb 2001 18:05:47 -0600
To: Nathan Black <NBlack@md.aacisd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx (and sym53c8xx) plans
Message-ID: <20010217180547.B28785@cadcamlab.org>
In-Reply-To: <8FED3D71D1D2D411992A009027711D671897@md>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <8FED3D71D1D2D411992A009027711D671897@md>; from NBlack@md.aacisd.com on Thu, Feb 15, 2001 at 12:19:47PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Nathan Black]
> This really improved the performance of my dual PIII-866 w/512MB Ram
> and AIC7899 scsi.
[...]
> I would suggest, if at all possible, putting this in the 2.4.2
> kernel.

Have you any idea the breadth of cards and chips that aic7xxx supports?
Sure, Justin's driver does great with your shiny new 7899, but can you
verify that it also drives the 8-year-old EISA AHA-2740 I still have
sitting around (actually retired to the parts pile, but that's beside
the point, I'm sure some still exist in the wild)?  How about the VLB
card I have in my 486 at home?

IMHO there is no way Linus should consider replacing aic7xxx with 6.1
in a stable kernel.  Not until it has gotten as much testing on as much
obscure hardware as the old driver, which is not going to happen soon.
Breaking existing working setups in 2.4.x is not an option.  Possible
solution: let the two drivers coexist, like ncr53c8xx vs sym53c8xx or
tulip vs old_tulip.

Peter
