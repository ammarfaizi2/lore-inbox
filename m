Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTIHRhd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 13:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTIHRhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 13:37:20 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:32731 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263440AbTIHRhQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 13:37:16 -0400
Subject: Re: Question: monolitic_clock, timer_{tsc,hpet} and CPUFREQ
From: john stultz <johnstul@us.ibm.com>
To: Dominik Brodowski <linux@brodo.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20030907185755.GA19923@brodo.de>
References: <200309042214.28179.dtor_core@ameritech.net>
	 <1062749594.5809.7.camel@laptop.cornchips.homelinux.net>
	 <20030907185755.GA19923@brodo.de>
Content-Type: text/plain
Organization: 
Message-Id: <1063042214.1314.1586.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 Sep 2003 10:30:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-09-07 at 11:57, Dominik Brodowski wrote:
> On Fri, Sep 05, 2003 at 01:13:14AM -0700, john stultz wrote:
> > Looks fine to me. Although I don't have any cpufreq enabled hardware, so
> > I'm unable to test this (main cause I never added it myself). 
> 
> /me has cpufreq enabled hardware -- but how can I accurately debug
> monotonic_ticks()?

Usually I hack up the hangcheck-timer module to be more verbose to
verify monotonic_clock() works. Also Oracle has a hangcheck-delay module
you can use to hang the system for a defined length of time. You can
then check the delta between gettimeofday and monotonic_clock to verify
its working as it should.

thanks
-john




