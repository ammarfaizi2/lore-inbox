Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282861AbRLMJA3>; Thu, 13 Dec 2001 04:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282848AbRLMJAT>; Thu, 13 Dec 2001 04:00:19 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:19396
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S282805AbRLMJAF>; Thu, 13 Dec 2001 04:00:05 -0500
Date: Thu, 13 Dec 2001 03:49:30 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] CML2 1.9.7 is available
Message-ID: <20011213034930.A8337@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011212023556.A8819@thyrsus.com> <16992.1008153373@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16992.1008153373@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Wed, Dec 12, 2001 at 09:36:13PM +1100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au>:
> OUCH!  The output from make menuconfig has significantly more options
> than make oldconfig when given exactly the same input.  I thought one
> of the selling points for CML2 was different front ends but with
> identical back end processing.  I don't like the way that the resulting
> config varies when fed to different front ends.

Not a big deal -- all the produced config.outs are logically equivalent.
Your differences all consist of symbols saved out as n in one version and not
saved at all in the other.  It *would* be serious cause for alarm if that
were not the case.

The simplification in the saveability-predicate logic I just did for
1.9.8 made may help solve this problem.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

.. a government and its agents are under no general duty to 
provide public services, such as police protection, to any 
particular individual citizen...
        -- Warren v. District of Columbia, 444 A.2d 1 (D.C. App.181)
