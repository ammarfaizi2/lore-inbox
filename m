Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276223AbRI1S0S>; Fri, 28 Sep 2001 14:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276228AbRI1S0I>; Fri, 28 Sep 2001 14:26:08 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:34820 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S276222AbRI1SZy>; Fri, 28 Sep 2001 14:25:54 -0400
Date: Fri, 28 Sep 2001 14:26:21 -0400
Message-Id: <200109281826.f8SIQLP06585@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
X-Also-Posted-To: linux.dev.kernel
Subject: Re: 2.4.9-ac16 good perfomer?
In-Reply-To: <Pine.LNX.4.33L.0109280049380.19147-100000@imladris.rielhome.conectiva>
Distribution: local
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Reply-To: davidsen@tmr.com (bill davidsen)
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33L.0109280049380.19147-100000@imladris.rielhome.conectiva>,
Rik van Riel <riel@conectiva.com.br> wrote:
| On Thu, 27 Sep 2001, Thomas Hood wrote:
| 
| > Either 2.4.9-ac16 has much improved VM performance over
| > previous 2.4 kernels (under moderate load, at least), or someone
| > sneaked in to my apartment last night and upgraded my machine
| > while I was asleep.  I'm leaning toward the latter explanation.
| 
| Now that the -ac VM was stable for a few weeks, I thought
| it might be time to sneak in some big performance changes,
| finally.
| 
| They seem to work ;)

  I have been playing with 2.4.9-ac16 and I note that on a small machine
(without the highmem issues) it really seems much slower initially.
After startx I pop up netscape for a test, and it takes almost 50%
longer than 2.4.8-pre3 I've been running since it was new. After that it
seems okay but not wildly better, my aim was to be able to use netscape
and cdrecord and {anything_else} at the same time.

  I'm measuring some figures now, and I have to dig out the location of
the preempt stuff and see if it's in already, or will slide in without
breaking. My bookmarks are on backup while I use the 2nd drive for
something else today :-(

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe

