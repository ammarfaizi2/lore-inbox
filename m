Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752020AbWCNIYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbWCNIYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbWCNIYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:24:24 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:44510 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1752020AbWCNIYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:24:23 -0500
Date: Tue, 14 Mar 2006 09:24:17 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, Pavel Machek <pavel@ucw.cz>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: does swsusp suck after resume for you? [was Re: Faster resuming of suspend technology.]
Message-ID: <20060314082417.GA7476@rhlx01.fht-esslingen.de>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060313113631.GA1736@elf.ucw.cz> <200603132303.18758.kernel@kolivas.org> <200603141613.10915.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603141613.10915.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 14, 2006 at 04:13:10PM +1100, Con Kolivas wrote:
> Since my warning probably scared anyone from actually trying this patch I've 
> given it a thorough working over on my own laptop, booting with mem=128M. The 
> patch works fine and basically with the patch after resuming from disk I have 
> 25MB more memory in use with pages prefetched from swap. This makes a 
> noticeable difference to me. That's a pretty artificial workload, so if 
> someone who actually has lousy wakeup after resume could test the patch it 
> would be appreciated.

I did try it, but ran into weird unrelated compile failures multiple times
(sorry, no log).

Andreas Mohr
