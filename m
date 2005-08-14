Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVHNTsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVHNTsY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 15:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVHNTsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 15:48:24 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:35523 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932067AbVHNTsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 15:48:23 -0400
Subject: Re: [GIT PATCH] scsi bug fixes for 2.6.13
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60.0508142121000.4594@poirot.grange>
References: <1123184634.5026.58.camel@mulgrave>
	 <Pine.LNX.4.60.0508142121000.4594@poirot.grange>
Content-Type: text/plain
Date: Sun, 14 Aug 2005 14:48:10 -0500
Message-Id: <1124048890.18802.13.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-14 at 21:33 +0200, Guennadi Liakhovetski wrote:
> Just to make sure everyone agrees on this - there's currently a know bug 
> in dc395x with highmem reported by Pierre Ossman in thread "Kernel panic 
> with dc395x in 2.6.12.2" on linux-scsi. It is also trivial to reproduce on 
> non-highmem machines. It was there also in 2.6.12. It only was hit by one 
> person because not many use dc395x controlled cards in highmem machines 
> today. The fix is known - at least revert my patch to dc395x commited to 
> 2.6.12-rc5. This will fix this bug, leaving another one, which is much 
> harder to hit. There was only one person who hit it, but he cannot test 
> any more patches - the hardware is not there any more. I think I have a 
> fix for that one too, but that's another story. So, I would say it would 
> be worth it reverting that patch before 2.6.13, but, that's because I feel 
> personal responsibility for that bug:-)

OK, why don't we do this.  Instead of having me trawl through the trees
looking for the correct patch to reverse, why don't you attach it in an
email and I'll try to get it in to 2.6.13?

James


