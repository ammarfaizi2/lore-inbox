Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270521AbSISIJS>; Thu, 19 Sep 2002 04:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270528AbSISIJR>; Thu, 19 Sep 2002 04:09:17 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:36589 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S270521AbSISIJO>;
	Thu, 19 Sep 2002 04:09:14 -0400
Message-ID: <1032423255.3d89875787cb4@kolivas.net>
Date: Thu, 19 Sep 2002 18:14:15 +1000
From: Con Kolivas <conman@kolivas.net>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] contest results for 2.5.36
References: <Pine.LNX.4.44L.0209181349200.1519-100000@duckman.distro.conectiva> <E17rwJh-0000vS-00@starship>
In-Reply-To: <E17rwJh-0000vS-00@starship>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Phillips <phillips@arcor.de>:

> On Wednesday 18 September 2002 18:50, Rik van Riel wrote:
> > On Wed, 18 Sep 2002, Andrew Morton wrote:
> > 
> > > > No Load:
> > > > Kernel                  Time            CPU
> > > > 2.4.19                  68.14           99%
> > > > 2.4.20-pre7             68.11           99%
> > > > 2.5.34                  69.88           99%
> > > > 2.4.19-ck7              68.40           98%
> > > > 2.4.19-ck7-rmap         68.73           99%
> > > > 2.4.19-cc               68.37           99%
> > > > 2.5.36                  69.58           99%
> > >
> > > page_add/remove_rmap.  Be interesting to test an Alan kernel too.
> > 
> > Yes, but why are page_add/remove_rmap slower in 2.5 than in
> > Con's -rmap kernel ? ;)
> 
> I don't know what you guys are going on about, these differences are
> getting close to statistically insignificant.

These ones definitely are insignificant. I've found the limit with repeat
measurements about +/- 1%

Con.
