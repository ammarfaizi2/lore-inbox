Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261637AbSIWN6H>; Mon, 23 Sep 2002 09:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261666AbSIWN6H>; Mon, 23 Sep 2002 09:58:07 -0400
Received: from pcp01179415pcs.strl1201.mi.comcast.net ([68.60.208.36]:59890
	"EHLO mythical") by vger.kernel.org with ESMTP id <S261637AbSIWN6G>;
	Mon, 23 Sep 2002 09:58:06 -0400
Date: Mon, 23 Sep 2002 10:02:41 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Con Kolivas <conman@kolivas.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
Message-ID: <20020923140241.GQ1425@mythical.michonline.com>
Mail-Followup-To: Con Kolivas <conman@kolivas.net>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	gcc@gcc.gnu.org
References: <Pine.LNX.4.44.0209230945260.2917-100000@localhost.localdomain> <1032777021.3d8eed3d55f53@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032777021.3d8eed3d55f53@kolivas.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 08:30:21PM +1000, Con Kolivas wrote:
> Quoting Ingo Molnar <mingo@elte.hu>:
> > On Mon, 23 Sep 2002, Con Kolivas wrote:
> > 
> > how many times are you running each test? You should run them at least
> > twice (ideally 3 times at least), to establish some sort of statistical
> > noise measure. Especially IO benchmarks tend to fluctuate very heavily
> > depending on various things - they are also very dependent on the initial
> > state - ie. how the pagecache happens to lay out, etc. Ie. a meaningful
> > measurement result would be something like:
> 
> Yes you make a very valid point and something I've been stewing over privately
> for some time. contest runs benchmarks in a fixed order with a "priming" compile
> to try and get pagecaches etc back to some sort of baseline (I've been trying
> hard to make the results accurate and repeatable). 

Well, run contest once, discard the results.  Run it 3 more times, and
you should have started the second, third and fourth runs with similar initial conditions.

Or you could run the contest 3 times, rebooting between each run....
(automating that is a little harder, of course.)

IANAS, however.

-- 

Ryan Anderson
  sometimes Pug Majere
