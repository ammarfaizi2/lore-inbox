Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265638AbSJXUSs>; Thu, 24 Oct 2002 16:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265639AbSJXUSs>; Thu, 24 Oct 2002 16:18:48 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:64139 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265638AbSJXUSr>;
	Thu, 24 Oct 2002 16:18:47 -0400
Date: Thu, 24 Oct 2002 21:26:54 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021024202654.GA14351@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ed Sweetman <ed.sweetman@wmich.edu>, linux-kernel@vger.kernel.org
References: <3DB82ABF.8030706@colorfullife.com> <200210242048.36859.earny@net4u.de> <3DB85385.6030302@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB85385.6030302@wmich.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 04:09:41PM -0400, Ed Sweetman wrote:
 > 
 > I seem to be seeing compiler optimizations come into play with the 
 > numbers and not any mention of them that i've seen has been talked 
 > about. That could be causing any discrepencies with predicted values. So 
 > not only would we have to look at algorithms, but also the compilers and 
 > what optimizations we plan on using them with.  Some do better on 
 > certain compilers+flags than others. It's a mixmatch that seems to only 
 > get complicated the more realistic you make it.

The functions being benchmarked are written in assembly.
gcc will not change these in any way, making compiler flags
or revision irrelevant.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
