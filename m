Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318080AbSIABgU>; Sat, 31 Aug 2002 21:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318085AbSIABgU>; Sat, 31 Aug 2002 21:36:20 -0400
Received: from holomorphy.com ([66.224.33.161]:57745 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318080AbSIABgT>;
	Sat, 31 Aug 2002 21:36:19 -0400
Date: Sat, 31 Aug 2002 18:37:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Rik van Riel <riel@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] adjustments to dirty memory thresholds
Message-ID: <20020901013744.GM888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Rik van Riel <riel@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D6D82A3.A3A0C7F0@zip.com.au> <Pine.LNX.4.44L.0208282306110.1857-100000@imladris.surriel.com> <3D6D8C88.BD4180CF@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D6D8C88.BD4180CF@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 07:52:56PM -0700, Andrew Morton wrote:
> Eeeks indeed.  But the main variables really are memory size,
> IO bandwidth and workload.  That's manageable.
> The traditional toss-it-in-and-see-who-complains approach will
> catch the weird corner cases but it's slow turnaround.  I guess
> as long as we know what the code is trying to do then it should be
> fairly straightforward to verify that it's doing it.

Okay, not sure which in the thread to respond to, but since I can't
find a public statement to this effect, in my testing, all 3 OOM
patches behave identically.


Cheers,
Bill
