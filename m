Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278333AbRJMQbR>; Sat, 13 Oct 2001 12:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278340AbRJMQbH>; Sat, 13 Oct 2001 12:31:07 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:54286 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S278333AbRJMQax>; Sat, 13 Oct 2001 12:30:53 -0400
Date: Sat, 13 Oct 2001 12:31:04 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Pentium IV cacheline size.
In-Reply-To: <20011013125733.A10917@suse.de>
Message-ID: <Pine.LNX.4.10.10110131225060.17521-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Currently, we're using a L1_CACHE_SHIFT value of 7
> for Pentium 4, which equates to 128 byte cache lines.
> Curious, I dumped the info on the only P4 I could find,
> and noticed they were 64 byte.

the value is correct, but the name should be SMP rather than L1,
since we (only?) use the value for aligning data to avoid false sharing.

regards, mark hahn

