Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267496AbSKSWdG>; Tue, 19 Nov 2002 17:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267511AbSKSWdG>; Tue, 19 Nov 2002 17:33:06 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:26075 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S267496AbSKSWdF>;
	Tue, 19 Nov 2002 17:33:05 -0500
Message-ID: <1037745604.3ddabdc4772b4@kolivas.net>
Date: Wed, 20 Nov 2002 09:40:04 +1100
From: Con Kolivas <conman@kolivas.net>
To: Robert Love <rml@tech9.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.48-mm1 with contest
References: <1037741326.3ddaad0ef119d@kolivas.net> <1037741983.1504.2229.camel@phantasy>
In-Reply-To: <1037741983.1504.2229.camel@phantasy>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robert Love <rml@tech9.net>:

> On Tue, 2002-11-19 at 16:28, Con Kolivas wrote:
> 
> > xtar_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.48 [5]              184.4   41      2       6       2.52
> > 2.5.48-mm1 [5]          210.7   35      2       6       2.88
> >
> > read_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.48 [5]              102.9   74      6       4       1.41
> > 2.5.48-mm1 [5]          256.7   29      11      2       3.51*
> 
> What changed, Andrew?
> 
> Wall time is up but CPU is down... spending more time on I/O?
> 
> Con, mind refreshing me on what the LCPU% and Ratio columns mean?

 
LCPU% is the cpu% as reported by 'time load' - It will overestimate slightly.
Ratio is the simply kernel compile time over reference (in this case 2.4.18 with
no load). 

Con
