Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbTIUUfY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 16:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbTIUUfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 16:35:24 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:63222 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262572AbTIUUfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 16:35:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16238.2932.99763.591328@gargle.gargle.HOWL>
Date: Sun, 21 Sep 2003 22:35:00 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Matt Hahnfeld <matth@everysoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SLOW machine when HIGHMEM enabled (1gb memory, kernel 2.4.22)
In-Reply-To: <Pine.LNX.4.44.0309211558570.12232-100000@sotec>
References: <Pine.LNX.4.44.0309211558570.12232-100000@sotec>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Hahnfeld writes:
 > I have an ASUS P4P800-VM motherboard with 2 sticks of 512mb PC3200 and
 > a single 2.4 ghz P4 processor.  The kernel is vanilla 2.4.22 configured
 > for SMP (hyperthreading).
 > 
 > When I use a kernel with high memory support off, I get good
 > performance (despite not being able to use some of my memory).  When I
 > enable CONFIG_HIGHMEM4G the remaining memory is detected, but the
 > machine takes a big performance hit and starts running very slow --
 > ie. kernel compilation looks like it would take 5 days instead of 5
 > minutes.  /proc/meminfo doesn't look particularly strange and no
 > strange log messages show up -- everything just runs slow...
 > 
 > CONFIG_HIGHMEM64G produces the same results...
 > 
 > Any suggestions?

Sounds like maybe the high RAM isn't cacheable.
What does /proc/mtrr and dmesg look like?

Have you verified that you're running the latest BIOS?
