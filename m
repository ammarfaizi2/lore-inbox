Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272104AbRHVTZo>; Wed, 22 Aug 2001 15:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272098AbRHVTZZ>; Wed, 22 Aug 2001 15:25:25 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:18396 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S272100AbRHVTZP>; Wed, 22 Aug 2001 15:25:15 -0400
Date: Wed, 22 Aug 2001 15:40:24 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops after mounting ext3 on 2.4.8-ac9
In-Reply-To: <3B83F79E.45B9CC34@zip.com.au>
Message-ID: <Pine.LNX.4.31.0108221537100.3959-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Andrew Morton wrote:

> USB problem.  Looks like dev->bus has a wild value in new_dev_inode().
> >From a quick scan I don't see any changes in ac8->ac9 which could cause
> this.  Please, work back through kernel versions until it goes away and
> let us know.

Sure enough, I mount /proc and /proc/bus/usb after the last disc
partition.

Yep, the oops persisted in 2.4.8-ac8, but went away as I went back to
-ac7.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

