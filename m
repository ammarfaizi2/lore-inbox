Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262428AbTC1Iwg>; Fri, 28 Mar 2003 03:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262772AbTC1Iwg>; Fri, 28 Mar 2003 03:52:36 -0500
Received: from [131.215.233.56] ([131.215.233.56]:18960 "EHLO bryanr.org")
	by vger.kernel.org with ESMTP id <S262428AbTC1Iwf>;
	Fri, 28 Mar 2003 03:52:35 -0500
Date: Fri, 28 Mar 2003 00:50:46 -0800
From: Bryan Rittmeyer <bryanr@bryanr.org>
To: John Levon <levon@movementarian.org>
Cc: oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] oprofile + ppc750cx perfmon
Message-ID: <20030328085046.GA6325@bryanr.org>
References: <20030325050900.GA30294@bryanr.org> <20030325085759.GB30294@bryanr.org> <20030325174309.GB57374@compsoc.man.ac.uk> <20030326035000.GA32590@bryanr.org> <20030327010121.GA94874@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327010121.GA94874@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 01:01:21AM +0000, John Levon wrote:
> Please try to keep to the style.

and lo, v0004 was born:

- use (3 KHz timebase / 2) for driving profiler
- fix startup collision between decrementer and perfmon
- dynamically enable/disable power management on start/stop
- use PVR to make sure we're on a supported CPU
- actually start/stop inside pm_start_cpu/pm_stop_cpu
- begin to implement syscall interception
- build system-related cleanups
- further comments
- style cleanups

http://bryanr.org/linux/oprofile/

-Bryan
