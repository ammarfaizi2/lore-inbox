Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318914AbSHMC7P>; Mon, 12 Aug 2002 22:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318915AbSHMC7P>; Mon, 12 Aug 2002 22:59:15 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:19717 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318914AbSHMC7O>; Mon, 12 Aug 2002 22:59:14 -0400
Date: Mon, 12 Aug 2002 22:56:53 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Peter Klotz <peter.klotz@aon.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 and 2.4.20-pre1 don't boot
In-Reply-To: <000501c24230$8a29bdd0$8c00000a@sledgehammer>
Message-ID: <Pine.LNX.3.96.1020812225422.7583B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Peter Klotz wrote:

> Up to 2.4.19-rc1 my system worked fine but 2.4.19 and 2.4.20-pre1 produce
> the following message at startup:
> 
> Mounting root filesystem
> ide-floppy driver 0.99.newide
> kmod: failed to exec /sbin/modprobe -s -k ide-cd, errno = 2
> hda: driver not present
> mount: error 6 mounting ext3
> pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
> Freeing unused kernel memory: 108k freed
> Kernel panic: No init found. Try passing init= option to kernel.

If you have multiple controllers one possible source is that the
controllers are being identified in the wrong order. This is an
enhancement in 2.4.19.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

