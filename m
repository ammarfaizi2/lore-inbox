Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbTL3Anz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 19:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbTL3Anz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 19:43:55 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47623 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263734AbTL3Anx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 19:43:53 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
Date: 30 Dec 2003 00:32:03 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bsqh23$fkr$1@gatekeeper.tmr.com>
References: <200312231138.21734.kernel@kolivas.org> <20031226225652.GE197@elf.ucw.cz> <3FED4838.6050908@kolumbus.fi>
X-Trace: gatekeeper.tmr.com 1072744323 16027 192.168.12.62 (30 Dec 2003 00:32:03 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3FED4838.6050908@kolumbus.fi>,
=?ISO-8859-1?Q?Mika_Penttil=E4?=  <mika.penttila@kolumbus.fi> wrote:

| heh...and the situation gets even worse when you add cpus, with 16way 
| you get only 1/16 of the speed ;)

No, not when you add CPUs, when you add siblings. There's a big
difference, since sibs compete for cache on the chip, and some execution
units (FPU?).
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
