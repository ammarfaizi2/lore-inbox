Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbTAaPP5>; Fri, 31 Jan 2003 10:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbTAaPP5>; Fri, 31 Jan 2003 10:15:57 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:49882 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261370AbTAaPP4>;
	Fri, 31 Jan 2003 10:15:56 -0500
Date: Fri, 31 Jan 2003 15:21:56 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Hans Reiser <reiser@namesys.com>
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] ext3, reiser, jfs, xfs effect on contest
Message-ID: <20030131152156.GA15977@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Hans Reiser <reiser@namesys.com>, Con Kolivas <conman@kolivas.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200302010020.34119.conman@kolivas.net> <3E3A7C22.1080709@namesys.com> <200302010040.49141.conman@kolivas.net> <3E3A8077.9050409@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E3A8077.9050409@namesys.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 04:56:07PM +0300, Hans Reiser wrote:
 > Try running with the -E option for gcc, it might be less CPU intensive, 
 > and thus a better FS benchmark.
 > 
 > What do you think?

It's hardly a realistic real-world benchmark if you start nobbling
bits of it though.  Not reading the preprocessed output is sure
to bump the benchmark points on an fs optimised for lots of small
writes.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
