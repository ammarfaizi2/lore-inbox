Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263536AbTIHTgU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbTIHTgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:36:20 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:4366 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263536AbTIHTgT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:36:19 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Scaling noise
Date: 8 Sep 2003 19:27:29 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bjil71$986$1@gatekeeper.tmr.com>
References: <20030903040327.GA10257@work.bitmover.com> <20030903124716.GE2359@wind.cocodriloo.com> <1062603063.1723.91.camel@spc9.esa.lanl.gov> <200309040350.31949.phillips@arcor.de>
X-Trace: gatekeeper.tmr.com 1063049249 9478 192.168.12.62 (8 Sep 2003 19:27:29 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200309040350.31949.phillips@arcor.de>,
Daniel Phillips  <phillips@arcor.de> wrote:

| As for Karim's work, it's a quintessentially flashy trick to make two UP 
| kernels run on a dual processor.  It's worth doing, but not because it blazes 
| the way forward for ccClusters.  It can be the basis for hot kernel swap: 
| migrate all the processes to one of the two CPUs, load and start a new kernel 
| on the other one, migrate all processes to it, and let the new kernel restart 
| the first processor, which is now idle.

UML running on a sibling, anyone? Interesting concept, not necessarily
useful.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
