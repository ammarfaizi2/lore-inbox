Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313767AbSFCMRK>; Mon, 3 Jun 2002 08:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314500AbSFCMRJ>; Mon, 3 Jun 2002 08:17:09 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:18413 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S313767AbSFCMRI>; Mon, 3 Jun 2002 08:17:08 -0400
Date: Mon, 3 Jun 2002 08:15:05 -0400
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre9aa2
Message-ID: <20020603121505.GA13261@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comparing 2.4.19pre8aa3 and 2.4.19pre9aa2 on quad Xeon:
Both kernels configured with CONFIG_2GB=y and CONFIG_HIGHIO=y.

dbench 64/192 on various filesystems had a 2-20% improvement.
(average 5 runs).

tbench 192 throughput up over 300%.

LMBench pipe bandwidth and latency improved.

The regression in OSDB aggregate simple report compared to
non-aa kernels is gone.

More benchmarks on quad Xeon at:
http://home.earthlink.net/~rwhron/kernel/bigbox.html

-- 
Randy Hron

