Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318326AbSG3QNw>; Tue, 30 Jul 2002 12:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318327AbSG3QNw>; Tue, 30 Jul 2002 12:13:52 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29453 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318326AbSG3QNv> convert rfc822-to-8bit; Tue, 30 Jul 2002 12:13:51 -0400
Date: Tue, 30 Jul 2002 12:08:19 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: memory leak?
In-Reply-To: <Pine.LNX.4.44L.0207211807300.12241-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.3.96.1020730120438.4042H-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jul 2002, Rik van Riel wrote:

> On 21 Jul 2002, Måns Rullgård wrote:
> 
> > Why can't proc/meminfo report these caches as cached instead of plain
> > used?  Would that be incorrect somehow?
> 
> The kernel exports the usage statistics in /proc/meminfo
> and /proc/slabinfo.  IMHO it's up to userland to present
> this info in a meaningful way, no need to shove that piece
> of functionality into the kernel.

What? The kernel is putting the data in /proc, it seems as easy to put all
cached memory in the cache bin as anywhere else. It's no more work to do
it right. No one is asking for new functionality, just the current
functionality being correct.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

