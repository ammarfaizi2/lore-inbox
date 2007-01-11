Return-Path: <linux-kernel-owner+w=401wt.eu-S1750871AbXAKQx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbXAKQx4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 11:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbXAKQx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 11:53:56 -0500
Received: from smtp19.orange.fr ([80.12.242.17]:27411 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbXAKQxz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 11:53:55 -0500
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jan 2007 11:53:55 EST
X-ME-UUID: 20070111164836435.6A5CE1C00049@mwinf1903.orange.fr
Subject: Re: O_DIRECT question
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org, mjt@tls.msk.ru
In-Reply-To: <Pine.LNX.4.64.0701110746360.3594@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
	 <Pine.LNX.4.64.0701101910110.3594@woody.osdl.org>
	 <45A5D4A7.7020202@yahoo.com.au>
	 <Pine.LNX.4.64.0701110746360.3594@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 11 Jan 2007 17:52:42 +0100
Message-Id: <1168534362.7365.3.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 11 janvier 2007 à 07:50 -0800, Linus Torvalds a écrit :
> > O_DIRECT is still crazily racy versus pagecache operations.
> 
> Yes. O_DIRECT is really fundamentally broken. There's just no way to fix 
> it sanely.

How about aliasing O_DIRECT to POSIX_FADV_NOREUSE (sortof) ?

	Xav


