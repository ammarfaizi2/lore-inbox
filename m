Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTJPWI2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 18:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbTJPWI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 18:08:28 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:59141 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263152AbTJPWI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 18:08:27 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH][2.6] constant_test_bit doesn't like my gcc
Date: 16 Oct 2003 21:58:34 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bmn4aa$ir9$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.53.0310152244330.2328@montezuma.fsmlabs.com> <20031015212134.41a427d3.akpm@osdl.org> <Pine.LNX.4.53.0310160020060.2328@montezuma.fsmlabs.com> <200310161255.36380.ioe-lkml@rameria.de>
X-Trace: gatekeeper.tmr.com 1066341514 19305 192.168.12.62 (16 Oct 2003 21:58:34 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200310161255.36380.ioe-lkml@rameria.de>,
Ingo Oeser  <ioe-lkml@rameria.de> asked:

| Sorry, but I still don't get, what a "const volatile" is supposed to mean.

It's a volatile which we're not allowed to change.

The ones which I always have to look at multiple times are the "const
pointer to volatile" and "volatile pointer to const." As in unchanging
pointer to a volatile datum, or a volatile pointer to unchanging data.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
