Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbTAaQlM>; Fri, 31 Jan 2003 11:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbTAaQlM>; Fri, 31 Jan 2003 11:41:12 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:34011 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261599AbTAaQlL>;
	Fri, 31 Jan 2003 11:41:11 -0500
Date: Fri, 31 Jan 2003 16:47:11 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Hans Reiser <reiser@namesys.com>
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] ext3, reiser, jfs, xfs effect on contest
Message-ID: <20030131164711.GA18147@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Hans Reiser <reiser@namesys.com>, Con Kolivas <conman@kolivas.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200302010020.34119.conman@kolivas.net> <3E3A7C22.1080709@namesys.com> <200302010040.49141.conman@kolivas.net> <3E3A8077.9050409@namesys.com> <20030131152156.GA15977@codemonkey.org.uk> <3E3AA6F6.3090504@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E3AA6F6.3090504@namesys.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 07:40:22PM +0300, Hans Reiser wrote:

 > >> Try running with the -E option for gcc, it might be less CPU intensive, 
 > >> and thus a better FS benchmark.
 > >> What do you think?
 > >It's hardly a realistic real-world benchmark if you start nobbling
 > >bits of it though.  Not reading the preprocessed output is sure
 > >to bump the benchmark points on an fs optimised for lots of small
 > >writes.
 > Sigh.  The alternative is to strace the compile, write a perl scipt or 
 > something to get just the FS related calls out of it, and then create a 
 > program with just the FS related calls. gcc -E sounds easier to me.;-)

It still seems like perverting a benchmark to turn it into dbench to me.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
