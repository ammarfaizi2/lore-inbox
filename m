Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264084AbTCXTuB>; Mon, 24 Mar 2003 14:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264370AbTCXTuB>; Mon, 24 Mar 2003 14:50:01 -0500
Received: from bitmover.com ([192.132.92.2]:62353 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264084AbTCXTuA>;
	Mon, 24 Mar 2003 14:50:00 -0500
Date: Mon, 24 Mar 2003 12:01:05 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: lmbench results for 2.4 and 2.5 -- updated results
Message-ID: <20030324200105.GA5522@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <C8C38546F90ABF408A5961FC01FDBF19010485F1@fmsmsx405.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF19010485F1@fmsmsx405.fm.intel.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 11:53:44AM -0800, Pallipadi, Venkatesh wrote:
> --- LMbench/src/lat_pagefault.c.org	Mon Mar 24 10:40:46 2003
> +++ LMbench/src/lat_pagefault.c	Mon Mar 24 10:54:34 2003
> @@ -67,5 +67,5 @@
>  		n++;
>  	}
>  	use_int(sum);
> -	fprintf(stderr, "Pagefaults on %s: %d usecs\n", file, usecs/n);
> +	fprintf(stderr, "Pagefaults on %s: %f usecs\n", file, (1.0 *
> usecs) / n);
>  }

It's been a long time since I've looked at this benchmark, has anyone 
stared at it and do you believe it measures anything useful?  If not,
I'll drop it from a future release.  If I remember correctly what I
was trying to do was to measure the cost of setting up the mapping
but I might be crackin smoke.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
