Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267123AbTBYWRM>; Tue, 25 Feb 2003 17:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268383AbTBYWRM>; Tue, 25 Feb 2003 17:17:12 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:44710 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267123AbTBYWRL>; Tue, 25 Feb 2003 17:17:11 -0500
Date: Tue, 25 Feb 2003 14:17:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <490220000.1046211468@flay>
In-Reply-To: <20030225221602.GZ29467@dualathlon.random>
References: <20030225171727.GN29467@dualathlon.random>
 <20030225174359.GA10411@holomorphy.com>
 <20030225175928.GP29467@dualathlon.random>
 <20030225185008.GF10396@holomorphy.com>
 <20030225191817.GT29467@dualathlon.random> <372680000.1046201260@flay>
 <20030225203001.GV29467@dualathlon.random> <417110000.1046206424@flay>
 <20030225211718.GY29467@dualathlon.random> <421460000.1046207575@flay>
 <20030225221602.GZ29467@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sure, it is more expensive to use them, but all we care about is
> complexity, and they solve the complexity problem just fine, so I
> definitely prefer it. Cpu utilization during heavy swapping isn't a big
> deal IMHO

I totally agree with you. However the concerns others raised were over
page aging and page stealing (eg from pagecache), which might not involve
disk, but would also be slower. It probably need some tuning and tweaking,
but I'm pretty sure it's fundamentally the right approach.

M.

