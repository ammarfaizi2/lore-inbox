Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262810AbSKCVTJ>; Sun, 3 Nov 2002 16:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262914AbSKCVTJ>; Sun, 3 Nov 2002 16:19:09 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:7579 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262810AbSKCVTH>;
	Sun, 3 Nov 2002 16:19:07 -0500
Date: Sun, 3 Nov 2002 21:24:21 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Akira Tsukamoto <at541@columbia.edu>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
Message-ID: <20021103212421.GA733@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Akira Tsukamoto <at541@columbia.edu>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	Hirokazu Takahashi <taka@valinux.co.jp>
References: <20021102025838.220E.AT541@columbia.edu> <3DC3A9C0.7979C276@digeo.com> <20021102214537.379A.AT541@columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102214537.379A.AT541@columbia.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 09:57:49PM -0500, Akira Tsukamoto wrote:

 > Personally I don't mind adding everything in .h or .c.
 > I just used the convention what string.h and string-486.h doing.
 > Isn't it confusing that adding everything in .c also?

As a sidenote, string-486.h has been disabled for years
(Right back to at least 2.0.39 which is the earliest tree I have
 to hand right now).  It should either be fixed, or considered
worth dropping imo.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
