Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbTKGWV4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbTKGWVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:21:22 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:43788 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264392AbTKGPNt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 10:13:49 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: CPU-Test similar to Memtest?
Date: 7 Nov 2003 15:03:21 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bogc7p$l07$1@gatekeeper.tmr.com>
References: <20031028160550.GA855@rdlg.net> <1067379433.6281.575.camel@tubarao>
X-Trace: gatekeeper.tmr.com 1068217401 21511 192.168.12.62 (7 Nov 2003 15:03:21 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1067379433.6281.575.camel@tubarao>,
Thayne Harbaugh  <tharbaugh@lnxi.com> wrote:

| On Tue, 2003-10-28 at 09:05, Robert L. Harris wrote:
| > I'm going to run MEMTEST today when I get home and get a chance to make
| > a bootable CD
| 
| Memtest86 is good, but it isn't as good as it could be.  Many times I
| have seen it run 24 hours without error even though the the system has
| bad memory.
| 
| >  but I'm wondering if there might be a "CPUTEST" or such
| > utility anyone knows of that'll poke and prod a dual athalon real well
| > and make sure I don't have a flaky cpu.
| 
| Run Linpack (or other computationally intensive program) while
| monitoring ECC errors with either
| http://www.anime.net/~goemon/linux-ecc/files/
| or
| ftp://ftp.lnxi.com/pub/bluesmoke

I agree with almost everything you said, but I have seen cases in which
no CPU use would generate an error, but using heavy DMA io in addition
triggered the problem. If all else fails add your favorite disk test.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
