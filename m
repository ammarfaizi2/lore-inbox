Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129248AbQLBC1O>; Fri, 1 Dec 2000 21:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQLBC1F>; Fri, 1 Dec 2000 21:27:05 -0500
Received: from rocko.intermag.com ([216.218.196.2]:31240 "EHLO
	rocko.intermag.com") by vger.kernel.org with ESMTP
	id <S129248AbQLBC0r>; Fri, 1 Dec 2000 21:26:47 -0500
Date: Fri, 1 Dec 2000 17:51:53 -0800
From: Jamie Manley <jamie@homebrewcomputing.com>
To: John Levon <moz@compsoc.man.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre24 and drm/agpgart static?
Message-ID: <20001201175153.B11780@homebrewcomputing.com>
In-Reply-To: <20001129203752.A15218@homebrewcomputing.com> <Pine.LNX.4.21.0012011450270.1317-100000@mrworry.compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012011450270.1317-100000@mrworry.compsoc.man.ac.uk>; from moz@compsoc.man.ac.uk on Fri, Dec 01, 2000 at 02:52:11PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2000 at 02:52:11PM +0000, John Levon wrote:
> > [drm] The mga drm module requires the agpgart module to function correctly
> > Please load the agpgart module before you load the mga module
> > 
> > Although XFree86 seems to be happy enough loading the dri and drm
> > modules.
> > 
> > Is this supposed to only work with modules?  .config snippet:
> > 
> > CONFIG_AGP=y
> > CONFIG_AGP_INTEL=y
> 
> Probably you have modversions enabled (CONFIG_MODVERSION=y). Disable that
> and try again, or build as modules. 2.4 fixed this problem in the proper
> way, but I don't know what's going to happen about 2.2 ...
> 
> john

I knew I should have posted the whole .config :)

Yes, modversions was enabled.  Should that be affecting the build of
the kernel proper?

Jamie

-- 
Jamie					        http://www.intermag.com
And I said, "This must be the place." -- Laurie Anderson, "Big Science"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
