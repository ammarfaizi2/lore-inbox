Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130791AbQLRITI>; Mon, 18 Dec 2000 03:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130245AbQLRISt>; Mon, 18 Dec 2000 03:18:49 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:62476 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129663AbQLRISr>; Mon, 18 Dec 2000 03:18:47 -0500
Date: Mon, 18 Dec 2000 01:47:03 -0600
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] link time error in drivers/mtd (240t13p2)
Message-ID: <20001218014702.C3199@cadcamlab.org>
In-Reply-To: <kaos@ocs.com.au> <200012171632.eBHGWGB01116@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012171632.eBHGWGB01116@sleipnir.valparaiso.cl>; from vonbrand@sleipnir.valparaiso.cl on Sun, Dec 17, 2000 at 01:32:15PM -0300
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Horst von Brand]
> Would tsort(1) perhaps help?

I'm betting Linus would never go for using tsort to resolve such issues
-- unless tsort output is guaranteed to be stable (the docs for GNU
textutils don't say).  This would be for the same reason that he
rejected the partial ordering in the LINK_FIRST patch -- because it was
only partial ordering and he thinks total ordering is necessary.  For
me, BTW, that's still an article of faith -- I still do not see why
total ordering *is* necessary, but <shrug> thus saith the penguin.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
