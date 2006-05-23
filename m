Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWEWB0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWEWB0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 21:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWEWB0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 21:26:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15243 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751238AbWEWB0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 21:26:30 -0400
Date: Tue, 23 May 2006 11:26:05 +1000
From: David Chinner <dgc@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Nathan Scott <nathans@sgi.com>, linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: XFS write speed drop
Message-ID: <20060523012605.GI5902445@melbourne.sgi.com>
References: <Pine.LNX.4.61.0605190047430.23455@yvahk01.tjqt.qr> <20060522105326.A212600@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0605221308290.11108@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605221308290.11108@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 02:21:48PM +0200, Jan Engelhardt wrote:
> >You're a bit light on details here.
> >
> >Can you send the benchmark results themselves please?  (as in,
> >the test(s) you've run that lead you to see 6-8x, and the data
> >those tests produced).  Also, xfs_info output, and maybe list
> >the device driver(s) involved here too.

Jan, just out of curiousity, can you also run the tests with
barriers off and the drive write cache turned off? I would
expect the cache+barriers to be faster...

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
