Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318304AbSHUOFn>; Wed, 21 Aug 2002 10:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318305AbSHUOFn>; Wed, 21 Aug 2002 10:05:43 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:41966 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318304AbSHUOFm>; Wed, 21 Aug 2002 10:05:42 -0400
Subject: Re: [PATCH] tsc-disable_B9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
In-Reply-To: <20020821131223.GB1117@dualathlon.random>
References: <1028771615.22918.188.camel@cog>
	<1028812663.28883.32.camel@irongate.swansea.linux.org.uk>
	<1028860246.1117.34.camel@cog> <20020815165617.GE14394@dualathlon.random>
	<1029496559.31487.48.camel@irongate.swansea.linux.org.uk>
	<15708.64483.439939.850493@kim.it.uu.se> 
	<20020821131223.GB1117@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 15:10:24 +0100
Message-Id: <1029939024.26425.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 14:12, Andrea Arcangeli wrote:
> However here the point is that the TSC was left _enabled_ (not disabled
> and emulated as you are advocating) despite it was not in sync. That
> cannot make any sense, except if you use the tsc as a random number
> generator.

Totally untrue. When you are doing profiling the data is very useful
because CPU switches are trivial to filter and statistically rare

