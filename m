Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVFROzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVFROzl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 10:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVFROzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 10:55:41 -0400
Received: from leb.cs.unibo.it ([130.136.1.102]:57048 "EHLO leb.cs.unibo.it")
	by vger.kernel.org with ESMTP id S262132AbVFROzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 10:55:35 -0400
Date: Sat, 18 Jun 2005 16:55:10 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.6.12 cpu-freq conservative governor problem
Message-ID: <20050618145510.GA16287@cs.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: pmarchet@cs.unibo.it (Paolo Marchetti)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello world,
I'm trying the brand new conservative governor on my p4 2.66 laptop
("Intel Pentium 4 clock modulation" only), it doesn't work at all (my
cpu does not scale).

cat cpufreq/conservative/sampling_rate_max
2755359744

cat cpufreq/scaling_max_freq
2666600

I don't get this...
ondemand governor works fine as usual.

TIA
