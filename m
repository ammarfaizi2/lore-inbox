Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264546AbSIWFIB>; Mon, 23 Sep 2002 01:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264555AbSIWFIA>; Mon, 23 Sep 2002 01:08:00 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:34951 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S264546AbSIWFIA>;
	Mon, 23 Sep 2002 01:08:00 -0400
Message-ID: <1032757988.3d8ea2e4a0618@kolivas.net>
Date: Mon, 23 Sep 2002 15:13:08 +1000
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Ville Herva <vherva@niksula.hut.fi>,
       Daniel Jacobowitz <dan@debian.org>, Robert Love <rml@tech9.net>
Subject: Re: [BENCHMARK] gcc3.2 v 2.95.3 (contest and linux-2.5.38)
References: <1032750261.3d8e84b5486a9@kolivas.net> <3D8E8D7F.810EF57F@digeo.com> <20020923034626.GA28612@nevyn.them.org> <1032753047.3d8e8f973e17d@kolivas.net> <3D8E9158.4E3DE029@digeo.com> <1032754853.3d8e96a520836@kolivas.net> <3D8E988F.DCB3196D@digeo.com>
In-Reply-To: <3D8E988F.DCB3196D@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton <akpm@digeo.com>:

> Con Kolivas wrote:
> > 
> > Quoting Andrew Morton <akpm@digeo.com>:
> > 
> > > Con Kolivas wrote:
> > > >
> > > > Correct. contest was run with gcc2.95.3 only. The kernels were
> compiled
> > > with
> > > > 2.95.3 and 3.2 respectively.
> > >
> > > I think you made a mistake.  Please rerun. Just one data point will do.
> > >
> > 
> > Ok here are two points to confirm the results and their reproducibility:
> > 
> > No Load:
> > 2.5.38                  68.25           99%
> > 2.5.38-gcc32            103.03          99%
> > 2.5.38-gcc32a           103.47          99%
> > 
> > Process Load:
> > 2.5.38                  71.60           95%
> > 2.5.38-gcc32            112.98          91%
> > 2.5.38-gcc32a           113.60          91%
> > 
> 
> beats the hell out of me.  Frankly, I *still* think
> you made a mistake (at least on the io load thing)
> because the CPU time went down by a mile - it was
> waiting on disk all the time.

If you think I've made a mistake then you're probably correct. I'm investigating
this further. Please do NOT pass judgement on these benchmarks until I
completely retest everything, ensuring gcc is fixed for everything except the
kernel being tested. Disregard until I have a fresh set of confirmed results.

Con.
