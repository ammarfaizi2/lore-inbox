Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316637AbSGQUNz>; Wed, 17 Jul 2002 16:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316649AbSGQUNz>; Wed, 17 Jul 2002 16:13:55 -0400
Received: from ns.suse.de ([213.95.15.193]:59151 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316662AbSGQUNt>;
	Wed, 17 Jul 2002 16:13:49 -0400
Date: Wed, 17 Jul 2002 22:16:40 +0200
From: Dave Jones <davej@suse.de>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org, Steven Cole <scole@lanl.gov>,
       wli@holomorphy.com
Subject: Re: 2.5.25-dj2, kernel BUG at dcache.c:361
Message-ID: <20020717221640.D32389@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org,
	Steven Cole <scole@lanl.gov>, wli@holomorphy.com
References: <1026936410.11636.107.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026936410.11636.107.camel@spc9.esa.lanl.gov>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 02:06:50PM -0600, Steven Cole wrote:
 > While running 2.5.25-dj2 and dbench with increasing numbers of clients,
 > my test machine locked up with the following message:
 > 
 > kernel BUG at dcache.c:361!

There are some -dj specific hacks to dcache.c to convert to use
list_t types. Which from memory, I think William Lee Irwin did.
(wli, can you double check those just in case there's either an
 obvious thinko, or a mismerge if you get time ?)

Failing that, this could be something that also affects mainline
I think.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
