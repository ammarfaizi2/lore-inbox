Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbTIUUKa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 16:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbTIUUKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 16:10:30 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:26869 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262554AbTIUUK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 16:10:29 -0400
Date: Sun, 21 Sep 2003 16:10:09 -0400 (EDT)
From: Matt Hahnfeld <matth@everysoft.com>
X-X-Sender: hahnfld@sotec
To: linux-kernel@vger.kernel.org
Subject: SLOW machine when HIGHMEM enabled (1gb memory, kernel 2.4.22)
Message-ID: <Pine.LNX.4.44.0309211558570.12232-100000@sotec>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ASUS P4P800-VM motherboard with 2 sticks of 512mb PC3200 and
a single 2.4 ghz P4 processor.  The kernel is vanilla 2.4.22 configured
for SMP (hyperthreading).

When I use a kernel with high memory support off, I get good
performance (despite not being able to use some of my memory).  When I
enable CONFIG_HIGHMEM4G the remaining memory is detected, but the
machine takes a big performance hit and starts running very slow --
ie. kernel compilation looks like it would take 5 days instead of 5
minutes.  /proc/meminfo doesn't look particularly strange and no
strange log messages show up -- everything just runs slow...

CONFIG_HIGHMEM64G produces the same results...

Any suggestions?

