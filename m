Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266153AbSKUMvN>; Thu, 21 Nov 2002 07:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266274AbSKUMvN>; Thu, 21 Nov 2002 07:51:13 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:56209 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266153AbSKUMvM>;
	Thu, 21 Nov 2002 07:51:12 -0500
Date: Thu, 21 Nov 2002 12:55:54 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling x86 with and without frame pointer
Message-ID: <20021121125554.GA9883@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
References: <19005.1037854033@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19005.1037854033@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 03:47:13PM +1100, Keith Owens wrote:
 > The conventional wisdom is that compiling x86 without frame pointer
 > results in smaller code.  It turns out to be the opposite, compiling
 > with frame pointers results in a smaller kernel.  gcc version 3.2
 > 20020822 (Red Hat Linux Rawhide 3.2-4).

I've been pushing a forward port of the CONFIG_FRAME_POINTER changes
that went into 2.4 for a while, but Linus hasn't taken them each time.
I'll keep pushing until I get a comment..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
