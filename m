Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbTCQOjF>; Mon, 17 Mar 2003 09:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261694AbTCQOjF>; Mon, 17 Mar 2003 09:39:05 -0500
Received: from [207.61.129.108] ([207.61.129.108]:11198 "EHLO
	mail.datawire.net") by vger.kernel.org with ESMTP
	id <S261700AbTCQOjE>; Mon, 17 Mar 2003 09:39:04 -0500
From: Shawn Starr <shawn.starr@datawire.net>
Organization: Datawire Communication Networks Inc.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.6x][PROBLEMS] - Panics relating to IRQ mishandlings and Timer releases
Date: Mon, 17 Mar 2003 09:51:55 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303170951.55517.shawn.starr@datawire.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone been having IRQ mishandling problems in the later 2.5.6x kernels? 

My poor IBM seems to be panicing randomly with system calls to irq functions. 

1) Panic on sending a 1.3GB file from other PC to the IBM while sound blaster 
was playing some mp3s

2) The IBM Panics when I turn on the PC next to it (NOT grounding problem) we 
get a kernel panic with softirq and timers.

I know timers changed alot from 2.4 -> 2.5 but this problem is a showstopper 
at least for me.

I first thought it was serial related but having the panic happen after 
sending a large file makes me wonder if there's something broken with timers 
and interrupt handling (whos not releasing that timer!).

Thanks, 

Shawn.

-- 
Shawn Starr
UNIX Systems Administrator, Operations
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
"The power to Transact" - http://www.datawire.net

