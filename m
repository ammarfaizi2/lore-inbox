Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281806AbRLBVY1>; Sun, 2 Dec 2001 16:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281797AbRLBVYS>; Sun, 2 Dec 2001 16:24:18 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:62989 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281806AbRLBVYF>; Sun, 2 Dec 2001 16:24:05 -0500
Message-ID: <3C0A9BD7.47473324@zip.com.au>
Date: Sun, 02 Dec 2001 13:23:35 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <20011130181415.C19152@work.bitmover.com> <200112012305.fB1N5xf1020409@sleipnir.valparaiso.cl>,
		<200112012305.fB1N5xf1020409@sleipnir.valparaiso.cl>; from vonbrand@sleipnir.valparaiso.cl on Sat, Dec 01, 2001 at 08:05:59PM -0300 <20011202122940.B2622@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> 
> Really?  So then people should be designing for 128 CPU machines, right?

Linux only supports 99 CPUs.  At 100, "ksoftirqd_CPU100" overflows
task_struct.comm[].

Just thought I'd sneak in that helpful observation.

-
