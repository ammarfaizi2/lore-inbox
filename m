Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129189AbRBSPdf>; Mon, 19 Feb 2001 10:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129283AbRBSPdY>; Mon, 19 Feb 2001 10:33:24 -0500
Received: from md.aacisd.com ([64.23.207.34]:39942 "HELO md.aacisd.com")
	by vger.kernel.org with SMTP id <S129189AbRBSPdP>;
	Mon, 19 Feb 2001 10:33:15 -0500
Message-ID: <8FED3D71D1D2D411992A009027711D671898@md>
From: Nathan Black <NBlack@md.aacisd.com>
To: "'Peter Samuelson'" <peter@cadcamlab.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: aic7xxx (and sym53c8xx) plans
Date: Mon, 19 Feb 2001 10:28:33 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actuall, I have tried it on a few machines now. It "seems" to work very
reliable with a 2940UW card, AIC 7890 chip, and a 2940U2W Card that I have
on my machines.(obviously these are all different machines). 

Nathan
-----Original Message-----
From: Peter Samuelson [mailto:peter@cadcamlab.org]
Sent: Saturday, February 17, 2001 7:06 PM
To: Nathan Black
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx (and sym53c8xx) plans



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
