Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268643AbTBZFQ2>; Wed, 26 Feb 2003 00:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268644AbTBZFQ2>; Wed, 26 Feb 2003 00:16:28 -0500
Received: from 200-195-242-247.cwb.visp.ifx.net.br ([200.195.242.247]:47585
	"EHLO 200-195-242-247.cwb.visp.ifx.net.br") by vger.kernel.org
	with ESMTP id <S268643AbTBZFQ1>; Wed, 26 Feb 2003 00:16:27 -0500
Date: Wed, 26 Feb 2003 02:24:18 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrea Arcangeli <andrea@suse.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@digeo.com>, Hanna Linder <hannal@us.ibm.com>,
       "" <lse-tech@lists.sf.et>, "" <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <20030225212635.GE10411@holomorphy.com>
Message-ID: <Pine.LNX.4.50L.0302260221380.17379-100000@imladris.surriel.com>
References: <20030222192424.6ba7e859.akpm@digeo.com> <20030225171727.GN29467@dualathlon.random>
 <20030225174359.GA10411@holomorphy.com> <20030225175928.GP29467@dualathlon.random>
 <20030225185008.GF10396@holomorphy.com> <20030225191817.GT29467@dualathlon.random>
 <372680000.1046201260@flay> <20030225203001.GV29467@dualathlon.random>
 <417110000.1046206424@flay> <20030225211718.GY29467@dualathlon.random>
 <20030225212635.GE10411@holomorphy.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003, William Lee Irwin III wrote:

> My impression thus far is that the anonymous case has not been pressing
> with respect to space consumption or cpu time once the file-backed code
> is in place, though if it resurfaces as a serious concern the anonymous
> rework can be pursued (along with other things).

... but making the anonymous pages use an object based
scheme probably will make things too expensive.

IIRC the object based reverse map patches by bcrl and
davem both failed on the complexities needed to deal
with anonymous pages.

My instinct is that a hybrid system will work well in
most cases and the worst case with mapped files won't
be too bad.

cheers,

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/
