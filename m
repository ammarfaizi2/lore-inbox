Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291931AbSBATjB>; Fri, 1 Feb 2002 14:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291930AbSBATiv>; Fri, 1 Feb 2002 14:38:51 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:7135 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S291932AbSBATie>; Fri, 1 Feb 2002 14:38:34 -0500
Date: Fri, 1 Feb 2002 13:38:33 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
Message-ID: <20020201133833.B8599@asooo.flowerfire.com>
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <a3enf3$93p$1@cesium.transmeta.com>; from hpa@zytor.com on Fri, Feb 01, 2002 at 10:40:35AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 10:40:35AM -0800, H. Peter Anvin wrote:
[...]
| > Exhausting entropy to zero under high use is not uncommon (that is a
| > motivation for my netdev-random patch).  What boggles me is why it does
| > not regenerate?
[...]
| Anything that is meant to be a server really pretty much needs an
| enthropy generator these days.  We really should push vendors to
| provide it (together with serial console firmware and other "well,
| duh" things rackmount servers should have as a matter of course.)

Yes, in fact we do have entropy generators in some cases, especially on
Solaris.  I think this is a very good idea -- it would be extremely nice
to see this especially since SO much more is dependent upon entropy
these days.  More than about 7 years ago I would have thought entropy
was a nethack clone.

Of course, in my case deleting the /dev/random character node still
doesn't allow entropy to drain in (after at least a month) so I suspect
the kernel's entropy generation would be sufficient if it didn't
artificially stall or drain from within the kernel.

Thanks much,
-- 
Ken.
brownfld@irridia.com


| 
| 	-hpa
| -- 
| <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
| "Unix gives you enough rope to shoot yourself in the foot."
| http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
