Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSIDUUp>; Wed, 4 Sep 2002 16:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSIDUUo>; Wed, 4 Sep 2002 16:20:44 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39175 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315406AbSIDUUo>; Wed, 4 Sep 2002 16:20:44 -0400
Date: Wed, 4 Sep 2002 16:18:27 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SMP Netfinity 340 hangs under 2.4.19
In-Reply-To: <a05111608b98b96373cce@[129.98.90.227]>
Message-ID: <Pine.LNX.3.96.1020904161622.13195C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2002, Maurice Volaski wrote:

> A single processor Netfinity 340 running RedHat 7.1 and kernel 2.4.18 
> was recently upgraded to
> 
> 1) 1 GB RAM
> 2) second processor (1 Ghz Xeon)
> 3) 2.4.19 for SMP with bigmem and added NFS server patches and 
> ext3-related patches.
> 
> Heavily used processes are netatalk, samba, and NFS.
> 
> The box is now hard locking periodically (every several days).

Boot with the noapic option. Try a stock kernel before you add all those
patches.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

