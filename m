Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTJIUNe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 16:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTJIUNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 16:13:34 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54288 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262422AbTJIUNd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 16:13:33 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Dual Xeon 2.6GHz, Supermicro X5DPA-TGM (SerialATA): 2.4.x causes system pauses, 2.6.0-test6 works fine
Date: 9 Oct 2003 20:03:51 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bm4ev7$5u7$1@gatekeeper.tmr.com>
References: <20031007181339.GB1239@boom.net>
X-Trace: gatekeeper.tmr.com 1065729831 6087 192.168.12.62 (9 Oct 2003 20:03:51 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031007181339.GB1239@boom.net>,
Taner Halicioglu  <taner@taner.net> wrote:

| Hi, I just built a new system and under all the 2.4.x kernels I tried (latest
| redhat, and stock 2.4.22 as well) I would have 10-20s system pauses during
| stress testing (a simple kernel compile loop, using make -j4) - appeared to
| be disk subsystem, as I could change windows in screen, and network was
| working fine.  I tried several APIC and ACPI settings to no avail.  I tried
| disabling Hyperthreading - no dice.  I tried running a UP kernel - no dice.
| 
| Upon installing the 2.6.0-test6 kernel, the pauses were gone!  (for the most
| part... have an occasional 2s pause, but that is considerably better than
| 10-20s ;))

Try booting with elevator=deadline, see if the last pause goes away.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
