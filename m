Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268476AbTGNPbn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270584AbTGNPbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:31:43 -0400
Received: from 204.244.250.2.net-conex.com ([204.244.250.2]:43786 "EHLO
	mail4.angio.com") by vger.kernel.org with ESMTP id S268476AbTGNPbk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:31:40 -0400
Message-ID: <E2B3FD6B3FF2804CB276D9ED037268354FF620@mail4.angio.com>
From: "Hassard, Stephen" <SHassard@angio.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Enabling CPU freq scaling on VIA Cyrix 3 causes kernel l
	ockup / divide error
Date: Mon, 14 Jul 2003 08:46:19 -0700
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System: VIA Epia 800 Motherboard w/ VIA C3 Processor @ 800 MHz.

Kernel: 2.6.0-test1

Problem: When I enable CPUFreq scaling with longhaul, the kernel crashes on
startup with the following error:

>>
longhaul: VIA CPU detected. Longhaul version 2 supportred
longhaul: VRM 8.5 : Min VID=1.250 Max VID=1.250, 0 possible voltage scales
longhaul: MinMult(x10)=30 MaxMult(x10)=60
longhaul: Lowestspeed=0 Highestspeed=0
longhaul: FSB:0 Mult(x10):100
divide error: 0000 [#1]
CPU:    0
<<

Thanks,
Stephen Hassard
