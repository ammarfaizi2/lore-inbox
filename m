Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267870AbTAHUXr>; Wed, 8 Jan 2003 15:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267873AbTAHUXq>; Wed, 8 Jan 2003 15:23:46 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:51085 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S267870AbTAHUXp> convert rfc822-to-8bit;
	Wed, 8 Jan 2003 15:23:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: landley@trommello.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.53 with contest
Date: Thu, 9 Jan 2003 07:32:24 +1100
User-Agent: KMail/1.4.3
References: <200212261038.04015.conman@kolivas.net> <200301071944.18098.landley@trommello.org>
In-Reply-To: <200301071944.18098.landley@trommello.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301090732.24440.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 Jan 2003 6:44 am, Rob Landley wrote:
> On Wednesday 25 December 2002 23:37, Con Kolivas wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Here are some contest results using osdl hardware:
> >
> > Uniprocessor:
> > process_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.49 [5]              85.2    79      17      20      1.28
> > 2.5.50 [5]              84.8    79      17      19      1.27
> > 2.5.51 [2]              85.2    79      17      20      1.28
> > 2.5.52 [3]              84.4    79      17      19      1.26
> > 2.5.53 [7]              86.9    77      18      21      1.30
>
> Could you add a time per load metric?  (I.E. 86.9/21=4.14 seconds.  Yeah, I
> could do the math myself, but that and total time are usually what I'm
> trying to compare when I look at these.  Maybe it's just me...)

If you look at the information carefully the meaningful number is 

(Loads ) / ( process_load_time - no_load_time)

but keep an eye out for a new version soon.

Con
