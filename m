Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268659AbTBZGGg>; Wed, 26 Feb 2003 01:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268660AbTBZGGg>; Wed, 26 Feb 2003 01:06:36 -0500
Received: from holomorphy.com ([66.224.33.161]:50361 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268659AbTBZGGf>;
	Wed, 26 Feb 2003 01:06:35 -0500
Date: Tue, 25 Feb 2003 22:14:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Rik van Riel <riel@imladris.surriel.com>,
       Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030226061440.GM10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Rik van Riel <riel@imladris.surriel.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
	linux-kernel@vger.kernel.org
References: <20030225185008.GF10396@holomorphy.com> <20030225191817.GT29467@dualathlon.random> <372680000.1046201260@flay> <20030225203001.GV29467@dualathlon.random> <417110000.1046206424@flay> <20030225211718.GY29467@dualathlon.random> <20030225212635.GE10411@holomorphy.com> <Pine.LNX.4.50L.0302260221380.17379-100000@imladris.surriel.com> <20030226053805.GK10411@holomorphy.com> <10220000.1046239279@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10220000.1046239279@[10.10.2.4]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> The boxen I'm supposed to babysit need a high degree of resource
>> consciousness wrt. lowmem allocations, so there is a clear voice

On Tue, Feb 25, 2003 at 10:01:20PM -0800, Martin J. Bligh wrote:
> It seemed, at least on the simple kernel compile tests that I did, that all
> the long chains are not anonymous. It killed 95% of the space issue, which
> given the simplicity of the patch was pretty damned stunning. Yes, there's
> a pointer per page I guess we could kill in the struct page itself, but I
> think you already have a better method for killing mem_map bloat ;-)

I'm not going to get up in arms about this unless there's a serious
performance issue that's going to get smacked down that I want to have
a say in how it gets smacked down. aa is happy with the filebacked
stuff, so I'm not pressing it (much) further.

And yes, page clustering is certainly on its way and fast. I'm getting
very close to the point where a general announcement will be in order.
There's basically "one last big bug" and two bits of gross suboptimality
I want to clean up before bringing the world to bear on it.


-- wli
