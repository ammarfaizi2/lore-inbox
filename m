Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267638AbTAQTOQ>; Fri, 17 Jan 2003 14:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267641AbTAQTOQ>; Fri, 17 Jan 2003 14:14:16 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:21482 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267638AbTAQTOP>; Fri, 17 Jan 2003 14:14:15 -0500
Subject: Re: [PATCH] linux-2.5.59_timer-tsc-cleanup_A0
From: john stultz <johnstul@us.ibm.com>
To: Dominik Brodowski <linux@brodo.de>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, akpm@diego.com
In-Reply-To: <20030117090237.GA1523@brodo.de>
References: <1042771949.29942.19.camel@w-jstultz2.beaverton.ibm.com>
	 <22767.1042793253@www52.gmx.net>  <20030117090237.GA1523@brodo.de>
Content-Type: text/plain
Organization: 
Message-Id: <1042830989.29941.26.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 17 Jan 2003 11:16:29 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-17 at 01:02, Dominik Brodowski wrote:
> Hi John,
> 
> On Fri, Jan 17, 2003 at 09:47:33AM +0100, john stultz wrote:
> > Linus, Andrew, All,
> >         Just a resend/resync for 2.5.59. This patch cleans up the
> > timer_tsc code, removing the unused use_tsc variable and making
> > fast_gettimeoffset_quotient static.
> 
> use_tsc is _not_ unused -- it's used at least in time_cpufreq_notifier (even
> though time_cpufreq_notifier didn't introduce use_tsc, it's in there the
> same way it's in 2.4. time.c ). So please don't remove it.

<Groan> Oh yikes, that totally snuck by me.

Thanks for pointing that out, I'll remove the chance from my patch
immediately. 

thanks again,
-dumbo^W-john




