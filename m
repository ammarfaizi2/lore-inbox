Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313132AbSC1LMU>; Thu, 28 Mar 2002 06:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313133AbSC1LMA>; Thu, 28 Mar 2002 06:12:00 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:41996 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S313132AbSC1LL5>; Thu, 28 Mar 2002 06:11:57 -0500
Date: Thu, 28 Mar 2002 11:11:52 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Andi Kleen <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem benchmarks: ext2 vs ext3 vs jfs vs minix
In-Reply-To: <Pine.LNX.4.33.0203272354430.17217-100000@sphinx.mythic-beasts.com>
Message-ID: <Pine.LNX.4.33.0203281057350.30187-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2002, Matthew Kirkwood wrote:

> I'll try to find time to run these again tomorrow to convince
> myself that all is sane, but these numbers are usually pretty
> stable.

Here's another run, with noatime on, and default postgres
parameters.

        tuning? single  ir      mx-ir   oltp    mixed-oltp
                (sec)   (tps)   (sec)   (tps)   (sec)
ext3     dn     1296.30 66.34   207.59  69.19   318.26
ext3-wb  dn     1286.38 66.27   212.48  135.48  229.74
ext3-jd  dn     1293.08 68.72   209.33  113.40  283.97

Looks like I'll have to invest some time in tuning postgres
a little better before the filesystem becomes more of a
bottleneck.

Matthew.

