Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbUBERUz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUBERUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:20:55 -0500
Received: from gw-nl5.philips.com ([161.85.127.51]:17346 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP id S266281AbUBERUx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:20:53 -0500
Message-ID: <40227C20.80404@basmevissen.nl>
Date: Thu, 05 Feb 2004 18:23:44 +0100
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle <kyle@southa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ICH5 with 2.6.1 very slow
References: <164601c3ec06$be8bd5a0$b8560a3d@kyle>
In-Reply-To: <164601c3ec06$be8bd5a0$b8560a3d@kyle>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle wrote:

> Problem with ICH5?
> I read the list web, so please CC my email, thanks.
> 
> P4 2.6G HT, 2GB Ram, ICH5, WD250GB/8M x 2  (md raid 1), kernel 2.6.1
> Timing buffer-cache reads: 128 MB in 0.14 seconds =882.89 MB/sec
> Timing buffered disk reads: 64 MB in 2.14 seconds = 29.93 MB/sec
> 
> Celeron 1.3T, 1GB Ram, SIS630/5513, WD80GB/2M x 2 (md raid 1), kernel 2.6.1
> Timing buffer-cache reads: 128 MB in 1.24 seconds =103.08 MB/sec
> Timing buffered disk reads: 64 MB in 1.83 seconds = 35.00 MB/sec
> 
> Celeron 2.5G, 512MB Ram, i845/ICH4, WD120GB/8M x 2 (md raid 1), redhat
> kernel 2.4.20
> Timing buffer-cache reads:   128 MB in  0.35 seconds =365.71 MB/sec
> Timing buffered disk reads:  64 MB in  1.38 seconds = 46.38 MB/sec
> 

Is that a parallel IDE? I own a S-ATA IDE (also WD) with an ICH5. That
performs around 45-50MB/sec with 2.6.1. I've never tried 2.4.xx on it.

Bas.


