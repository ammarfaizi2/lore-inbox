Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130011AbQLRKDB>; Mon, 18 Dec 2000 05:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130331AbQLRKCw>; Mon, 18 Dec 2000 05:02:52 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:25872 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130011AbQLRKCl>; Mon, 18 Dec 2000 05:02:41 -0500
Date: Mon, 18 Dec 2000 03:31:54 -0600
To: Daiki Matsuda <dyky@df-usa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 asm-alpha/system.h has a problem
Message-ID: <20001218033154.F3199@cadcamlab.org>
In-Reply-To: <20001217153444N.dyky@df-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001217153444N.dyky@df-usa.com>; from dyky@df-usa.com on Sun, Dec 17, 2000 at 03:34:44PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Daiki Matsuda]
> I encounterd the problem that 'cdrdao' is not compilable in 2.2.18 on
> Alpha.  And I researched a little.

Then cdrdao has a problem.  It should not be including kernel headers
directly.  You are changing perfectly legal C.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
