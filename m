Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbTKJUla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 15:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbTKJUl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 15:41:29 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:4356 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264083AbTKJUl2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 15:41:28 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test9 vs sound
Date: 10 Nov 2003 20:30:55 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <booshv$6mr$1@gatekeeper.tmr.com>
References: <200310301008.27871.gene.heskett@verizon.net> <yw1xr80tzs0e.fsf@kth.se> <200310310813.02970.gene.heskett@verizon.net> <yw1x8yn1zfb8.fsf@kth.se>
X-Trace: gatekeeper.tmr.com 1068496255 6875 192.168.12.62 (10 Nov 2003 20:30:55 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <yw1x8yn1zfb8.fsf@kth.se>,
=?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se> wrote:
| Gene Heskett <gene.heskett@verizon.net> writes:
| 
| > Some of the tutorials in those links would seem to indicate that 
| > /etc/modules.conf has been renamed, which I have not, and my modutils 
| > are still the same as I've been using for a few months with 2.4.  I 
| > saw an announcement regarding a new modutils tool set last night, do 
| > I need to install that, and does that then fubar a 2.4.23-pre8 boot?
| 
| You need the new module-init-tools.  If you follow the instructions
| provided with them, things will continue to work with 2.4 kernels.

The only thing to watch out for is that the "probe" functionality was
removed from the new package, which requires manual loading of the
modules and testing of the status. Inconvenient if you need to do it at
boot time, otherwise write a script. That feature typically was used
only when the hardware for the initial drivers might be nonfunctional
and and alternative was needed.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
