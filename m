Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264749AbUEYPoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264749AbUEYPoI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 11:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUEYPoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 11:44:08 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:22682 "EHLO
	kartuli.timesys") by vger.kernel.org with ESMTP id S264749AbUEYPoC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 11:44:02 -0400
Message-ID: <40B369D5.7070805@timesys.com>
Date: Tue, 25 May 2004 11:44:21 -0400
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>The plan is to make this very light-weight, and to fit in with how we 
>already pass patches around - just add the sign-off to the end of the 
>explanation part of the patch. That sign-off would be just a single line 
>at the end (possibly after _other_ peoples sign-offs), saying:
>
>	Signed-off-by: Random J Developer <random@developer.org>
>  
>
To avoid the requirement of all submissions going through a single person,
we have a system of formal authorizations. Specific people are authorized
to release certain classes of work. Would the community object to a slight
modifications to the Signed-off-by lines from TimeSys? E.g.

Signed-off-by: La Monte H.P. Yarroll <piggy@timesys.com> under TS00062

This completes the traceability path all the way back to the VP who signed
off on TS00062.

>To keep the rules as simple as possible, and yet making it clear what it
>means to sign off on the patch, I've been discussing a "Developer's
>Certificate of Origin" with a random collection of other kernel
>developers (mainly subsystem maintainers).  This would basically be what
>a developer (or a maintainer that passes through a patch) signs up for
>when he signs off, so that the downstream (upstream?) developers know
>that it's all ok:
>
>	Developer's Certificate of Origin 1.0
>
>	By making a contribution to this project, I certify that:
>
>	(a) The contribution was created in whole or in part by me and I
>            have the right to submit it under the open source license
>	    indicated in the file; or
>
>	(b) The contribution is based upon previous work that, to the best
>	    of my knowledge, is covered under an appropriate open source
>	    license and I have the right under that license to submit that
>	    work with modifications, whether created in whole or in part
>	    by me, under the same open source license (unless I am
>	    permitted to submit under a different license), as indicated
>	    in the file; or
>
>	(c) The contribution was provided directly to me by some other
>	    person who certified (a), (b) or (c) and I have not modified
>	    it.
>  
>

I THINK I have a case not covered here. I sometimes need to post unpublished
work done by other people at my company. Since the work is not yet 
published,
the GPL doesn't really grant me any special rights. The authorization I use
to publish is in fact NOT an open source license. I think clause (b) could
probably be weakened to cover my case.

>...
>The above also allows for companies that have "release criteria" to have
>the company "release person" sign off on a patch, so that a company can
>easily incorporate their own internal release procedures and see that all
>the patches have gone through the right channel. At the same time it is
>meant to _not_ cause anybody to have to change how they work (ie there is
>no "extra paperwork" at any point).
>  
>
I'd like to include a link between the external path and our internal 
procedures.

-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell's sig

