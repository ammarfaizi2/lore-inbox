Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268963AbUHZOd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268963AbUHZOd2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268976AbUHZOaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:30:52 -0400
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:55051 "EHLO
	smtp-vbr12.xs4all.nl") by vger.kernel.org with ESMTP
	id S269006AbUHZO2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:28:33 -0400
Date: Thu, 26 Aug 2004 16:28:12 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1
Message-ID: <20040826142812.GA4092@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20040826014745.225d7a2c.akpm@osdl.org> <412DC47B.4000704@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412DC47B.4000704@kolivas.org>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Con Kolivas <kernel@kolivas.org>
Date: Thu, Aug 26, 2004 at 09:07:39PM +1000
> Andrew Morton wrote:
> >
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/
> >
> >- nicksched is still here.  There has been very little feedback, except 
> >that
> >  it seems to slow some workloads on NUMA.
> 
> The only feedback on nickshed was that it hurt NUMA 
> somewhat, SMT interactivity was broken (an easy enough oversight)

I take it that was why changing consoles between mutt and slrn would
include a pause of several seconds on a system with a single,
hyperthreaded cpu?

Is that fixed in 2.6.9-rc1-mm1?

Thanks,
Jurriaan
-- 
Living on Earth includes an annual free trip around the Sun.
Debian (Unstable) GNU/Linux 2.6.8.1-mm4 2x6078 bogomips load 0.06
