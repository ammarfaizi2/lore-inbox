Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWH1Abw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWH1Abw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 20:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWH1Abw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 20:31:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1944 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751274AbWH1Abv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 20:31:51 -0400
Date: Mon, 28 Aug 2006 10:31:13 +1000
From: Nathan Scott <nathans@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/xfs/xfs_bmap.c:xfs_bmapi(): fix a bug
Message-ID: <20060828103113.A3119251@wobbly.melbourne.sgi.com>
References: <20060826150654.GE4765@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060826150654.GE4765@stusta.de>; from bunk@stusta.de on Sat, Aug 26, 2006 at 05:06:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 05:06:55PM +0200, Adrian Bunk wrote:
> ...
> Since bma.conv is a char and XFS_BMAPI_CONVERT is 0x1000, bma.conv was 
> always assigned zero.

Yep, looks good, thanks Adrian.

cheers.

-- 
Nathan
