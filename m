Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTJUTkt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 15:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbTJUTkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 15:40:49 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:32531 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263290AbTJUTkr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 15:40:47 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [RFC] frandom - fast random generator module
Date: 21 Oct 2003 19:30:45 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn41h5$i87$1@gatekeeper.tmr.com>
References: <3F8E552B.3010507@users.sf.net> <200310161245.59939.ioe-lkml@rameria.de>
X-Trace: gatekeeper.tmr.com 1066764645 18695 192.168.12.62 (21 Oct 2003 19:30:45 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200310161245.59939.ioe-lkml@rameria.de>,
Ingo Oeser  <ioe-lkml@rameria.de> wrote:
| On Thursday 16 October 2003 10:22, Eli Billauer wrote:

| > (4) The module is small: 6kB of source code as a standalone module, and
| > 2.3 kB of kernel memory.
| 
| That's a price worth as an "default to off" option. We have much more
| seldom used stuff in the kernel and maintain it, which is a bigger mess
| than this.

Yes, and it could be disabled to take no resources, unlike the Athlon
pagefault bugfix, which is forced in all kernels instead of just those
destined for those which need the fix.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
