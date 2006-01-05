Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWAEANj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWAEANj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWAEANj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:13:39 -0500
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:36500 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750818AbWAEANi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:13:38 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: 2.6.15-ck1
Date: Thu, 5 Jan 2006 11:12:51 +1100
User-Agent: KMail/1.9
Cc: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200601041200.03593.kernel@kolivas.org> <1136406837.2839.67.camel@laptopd505.fenrus.org> <43BC40B5.90607@gorzow.mm.pl>
In-Reply-To: <43BC40B5.90607@gorzow.mm.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051112.52404.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 08:40, Radoslaw Szkodzinski wrote:
> Arjan van de Ven wrote:
> > On Wed, 2006-01-04 at 14:57 -0500, Dave Jones wrote:
> >
> > sounds like we need some sort of profiler or benchmarker or at least a
> > tool that helps finding out which timers are regularly firing, with the
> > aim at either grouping them or trying to reduce their disturbance in
> > some form.
>
> You mean something like a modification to timer debugging patch to
> record the last time the timer fired, right?
> Timertop could then detect the pattern and provide frequency, standard
> deviation and other statistical data.
> It would be much more expensive to test of course.

I don't think the timer debugging patch needs to give out any more info. The 
userspace tool should be able to do this with the amount of info the timer 
debugging patch is giving already.

Cheers,
Con
