Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318112AbSGRPG0>; Thu, 18 Jul 2002 11:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318113AbSGRPG0>; Thu, 18 Jul 2002 11:06:26 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:19464 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318112AbSGRPGZ>; Thu, 18 Jul 2002 11:06:25 -0400
Date: Thu, 18 Jul 2002 11:04:01 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: stoffel@lucent.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Backups done right (was [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
In-Reply-To: <15668.39927.923118.516621@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.3.96.1020718105612.7522B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002 stoffel@lucent.com wrote:

>   3a. lock mirrored volume, flush any outstanding transactions, break
>       mirror.
>                 --or--
>   3b. snapshot filesystem to another volume.

Good summary. The problem is that 3a either requires a double morror or
leaving the f/s un mirrored, and 3b can take a very long time for a big
f/s.

In general mauch of this can be addressed by only backing up small f/s and
using an application backup utility to backup the big stuff. Fortunately
the most common problem apps are databases and and they include this
capability. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

