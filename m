Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWAEAyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWAEAyd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWAEAuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:40 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:3797 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750939AbWAEAtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:46 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.15-ck1
Date: Thu, 5 Jan 2006 11:49:17 +1100
User-Agent: KMail/1.9
Cc: ck@vds.kolivas.org, Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
       Arjan van de Ven <arjan@infradead.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200601041200.03593.kernel@kolivas.org> <200601051112.52404.kernel@kolivas.org> <20060105002759.GB30967@redhat.com>
In-Reply-To: <20060105002759.GB30967@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051149.18335.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 11:27, Dave Jones wrote:
> On Thu, Jan 05, 2006 at 11:12:51AM +1100, Con Kolivas wrote:
>  > On Thursday 05 January 2006 08:40, Radoslaw Szkodzinski wrote:
>  > > Arjan van de Ven wrote:
>  > > > On Wed, 2006-01-04 at 14:57 -0500, Dave Jones wrote:
>  > > >
>  > > > sounds like we need some sort of profiler or benchmarker or at least
>  > > > a tool that helps finding out which timers are regularly firing,
>  > > > with the aim at either grouping them or trying to reduce their
>  > > > disturbance in some form.
>  > >
>  > > You mean something like a modification to timer debugging patch to
>  > > record the last time the timer fired, right?
>  > > Timertop could then detect the pattern and provide frequency, standard
>  > > deviation and other statistical data.
>  > > It would be much more expensive to test of course.
>  >
>  > I don't think the timer debugging patch needs to give out any more info.
>  > The userspace tool should be able to do this with the amount of info the
>  > timer debugging patch is giving already.
>
> In the absense of a pointer to a userspace tool, I found the following
> handy. (It also fixes a bug where it was printing garbage as process
> names).

Timertop and pmstats are here:
http://ck.kolivas.org/patches/dyn-ticks/

Cheers,
Con
