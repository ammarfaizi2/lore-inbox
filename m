Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbSKSMDw>; Tue, 19 Nov 2002 07:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbSKSMDw>; Tue, 19 Nov 2002 07:03:52 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:23526 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265211AbSKSMDv>;
	Tue, 19 Nov 2002 07:03:51 -0500
Date: Tue, 19 Nov 2002 12:08:34 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: PATCH: Recognize Tualatin cache size in 2.4.x
Message-ID: <20021119120834.GA32004@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ricardo Galli <gallir@uib.es>, linux-kernel@vger.kernel.org,
	marcelo@conectiva.com.br
References: <200211171549.gAHFnSrE021923@mnm.uib.es> <20021118190200.GA20936@suse.de> <200211182154.52081.gallir@uib.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211182154.52081.gallir@uib.es>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 09:54:52PM +0100, Ricardo Galli wrote:

 > It's very cosmetic but very annoying for P3 > 1GHz, where Linux <= 2.4.20-preX 
 > only reports 32 KB of cache and it also seems to ignore the "cachesize" 
 > parameter. Perhaps it really uses 256KB, but not sure.

There was a bug related to that parameter, I'm sure if the fix
went into the same patch, or a separate one. I'll check later.

 > I tested it in a Compaq Proliant 330ML-G2 (P3 1.4) and a kernel compilation is 
 > 100% faster if the patch is applied.

<raises eyebrows>. The SMP weighting used by various parts of the kernel
will be slightly off, but I'd be amazed if it made *that much*
difference.

 > PS: Dave, see you in Mallorca in 20 days :-)

Indeed 8-)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
