Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSIIOYb>; Mon, 9 Sep 2002 10:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSIIOYb>; Mon, 9 Sep 2002 10:24:31 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:27827 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S314546AbSIIOYa>; Mon, 9 Sep 2002 10:24:30 -0400
Subject: Re: 2.5.33-mm5
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
In-Reply-To: <3D7AF270.BE4AFBEB@digeo.com>
References: <3D7AF270.BE4AFBEB@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 09 Sep 2002 08:25:42 -0600
Message-Id: <1031581542.1984.230.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-08 at 00:47, Andrew Morton wrote:
> 
> URL: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.33/2.5.33-mm5/
> 
> +refill-rate-fix.patch
> 
>  Fix a problem in refill_inactive_zone() which could soak a lot of CPU.
> 
> +sleeping-release_page.patch
> 
>  Allow mapped->releasepage() to sleep again.  My passing in non-zero
>  gfp_mask.
> 
> +filemap-integration-fixes.patch
> 
>  Some fixes to the readv/writev rework.
> 
> Plus a lot of stabilisation, tuning and testing of the new VM latency
> control code.  Including fixing one rarely-occurring infinite loop
> which might explain Steve Cole's reported failure.

This looks pretty good so far.  The test box has run up to 112 dbench
clients successfully with 2.5.33-mm5, ext3 data=ordered, which is much
better than before.  Thanks.
 
...and there was much rejoicing. 

Steven


