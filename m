Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317497AbSGFHpv>; Sat, 6 Jul 2002 03:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317533AbSGFHpu>; Sat, 6 Jul 2002 03:45:50 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:18449 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S317497AbSGFHpt>;
	Sat, 6 Jul 2002 03:45:49 -0400
Date: Sat, 6 Jul 2002 09:48:24 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Jochen Suckfuell <jo-lkml@suckfuell.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Disk IO statistics still buggy
Message-ID: <20020706074824.GA24771@win.tue.nl>
References: <Pine.NEB.4.44.0207042030350.14934-100000@mimas.fachschaften.tu-muenchen.de> <Pine.LNX.3.96.1020706000838.12039A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020706000838.12039A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2002 at 12:15:47AM -0400, Bill Davidsen wrote:

> > Marcelos' BK repository (that will become 2.4.19-rc2) includes a patch to
> > remove these statistics completely from /proc/partitions...
> 
> Is this the new Linux way of life? Removing modules is hard, GET RID OF
> THE FEATURE! Stats in /proc/partitions are not always correct, GET RID OF
> THE FEATURE!

Shouting and exclamation marks - a bad sign.

You are mistaken. This has never been a feature.
It is not in 2.4.18, and it looks like it will not be in 2.4.19.

It is in some vendor kernels, but it is ugly and causes various problems.
If somebody cares about having statistics she should submit a patch
adding /proc/diskstat.

Andries
