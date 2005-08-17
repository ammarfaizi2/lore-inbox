Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbVHQMb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVHQMb4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 08:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVHQMb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 08:31:56 -0400
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:20424 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751105AbVHQMbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 08:31:55 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Date: Wed, 17 Aug 2005 22:31:39 +1000
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <43001E18.8020707@bigpond.net.au> <200508171800.56222.kernel@kolivas.org> <6bffcb0e05081704231ba09573@mail.gmail.com>
In-Reply-To: <6bffcb0e05081704231ba09573@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508172231.39403.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2005 21:23, Michal Piotrowski wrote:
> Hi,
>
> On 8/17/05, Con Kolivas <kernel@kolivas.org> wrote:
> > On Mon, 15 Aug 2005 22:29, Michal Piotrowski wrote:
> > > Hi,
> > > here are my benchmarks (part1):
> >
> > Want to try the staircase cpu scheduler in "compute" mode for the compute
> > intensive workloads?
> >
> > Thanks,
> > Con
>
> Yes, I'll try interbench ;).

No that's not what I was saying at all. I know you're planning on trying 
interbench. What I meant was you should enable "compute" mode for these 
kernel compile based benchmarks.
In a plugsched based kernel look in:
/sys/cpusched/staircase/
and set compute to 1

Cheers,
Con
