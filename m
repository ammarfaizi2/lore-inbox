Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313988AbSEDPah>; Sat, 4 May 2002 11:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314124AbSEDPag>; Sat, 4 May 2002 11:30:36 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:10939 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313988AbSEDPag>; Sat, 4 May 2002 11:30:36 -0400
Date: Sat, 4 May 2002 09:30:33 -0600
Message-Id: <200205041530.g44FUXo18390@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: paulus@samba.org
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: <15571.47377.913702.639488@argo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras writes:
> But when have you known a kernel hacker to be satisfied with just
> "faster than the previous system", as distinct from "as fast as I can
> reasonably make it go"? ;-)
[...]
> Don't get me wrong, I think it's great to have all the advantages
> that kbuild-2.5 brings.  However, I also think that those seconds
> spent in the startup code will tend to have a disproportionate
> effect on people's perceptions of the new system.  I know you have
> already spent a lot of effort on this, but I want to get in and have
> a look myself to see if I can spot anything that could be improved
> there.

As Keith says, the new code is faster and more robust than the old
code. Given that tracking kernel drift is a significant load on him,
it makes sense to incorporate the new code now. Once it's in, let
people get used to it and then we can look at optimising it, if need
be. Delaying introduction into the kernel tree because it's not 100%
optimised is wasteful.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
