Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261596AbSKID4F>; Fri, 8 Nov 2002 22:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSKID4F>; Fri, 8 Nov 2002 22:56:05 -0500
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:3465 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S261596AbSKID4E> convert rfc822-to-8bit; Fri, 8 Nov 2002 22:56:04 -0500
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Con Kolivas <conman@kolivas.net>, Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Date: Sat, 9 Nov 2002 05:02:48 +0100
User-Agent: KMail/1.4.7
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <200211090444.44658.Dieter.Nuetzel@hamburg.de> <200211091454.59322.conman@kolivas.net>
In-Reply-To: <200211091454.59322.conman@kolivas.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200211090502.48306.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 9. November 2002 04:54 schrieb Con Kolivas:
> >Andreww Morton wrote:
> >> Con Kolivas wrote:
> >> > io_load:
> >> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> >> > 2.4.18 [3]              474.1   15      36      10      6.64
> >> > 2.4.19 [3]              492.6   14      38      10      6.90
> >> > 2.4.19-ck9 [2]          140.6   49      5       5       1.97
> >> > 2.4.20-rc1 [2]          1142.2  6       90      10      16.00
> >> > 2.4.20-rc1aa1 [1]       1132.5  6       90      10      15.86
> >>
> >> 2.4.20-pre3 included some elevator changes.  I assume they are the
> >> cause of this.  Those changes have propagated into Alan's and Andrea's
> >> kernels.   Hence they have significantly impacted the responsiveness
> >> of all mainstream 2.4 kernels under heavy writes.
> >>
> >> (The -ck patch includes rmap14b which includes the read-latency2 thing)
> >
> >No, the 2.4.19-ck9 that I have (the default?) include -AA and preemption
> > (!!!)
>
> Err I made the ck patchset so I think I should know. ck9 came only as one
> patch which included O(1),Low Latency, Preempt, Compressed Caching,
> Supermount, ALSA and XFS. CK10-13 on the otherhand had optional Compressed
> Caching OR AA OR Rmap. By default since they are 2.4 kernels they all
> include the vanilla aa vm, but the ck trunk with AA has the extra AA vm
> addons only available in the -AA kernel set. If you disabled compressed
> caching in ck9 you got only the vanilla 2.4.19 vm.

Then I mixed it up with 2.4.19-llck5 -AA.
To much versions... Sorry!

-Dieter
