Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310274AbSCLBEV>; Mon, 11 Mar 2002 20:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310264AbSCLBEE>; Mon, 11 Mar 2002 20:04:04 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:29593 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S310272AbSCLBDm>; Mon, 11 Mar 2002 20:03:42 -0500
Date: Mon, 11 Mar 2002 19:03:37 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux-Kernel list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Caution about e100...
Message-ID: <20020311190337.B10303@asooo.flowerfire.com>
In-Reply-To: <3C887D34.4BE740F9@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C887D34.4BE740F9@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Mar 08, 2002 at 03:58:28AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this only refer to the e100 driver in 2.5.x?  The one from Intel
applied to 2.4.x has been very stable under heavy production loads for
months, from UP to 6-way SMP.  At least for me... famous last words.

Thx,
-- 
Ken.
brownfld@irridia.com

On Fri, Mar 08, 2002 at 03:58:28AM -0500, Jeff Garzik wrote:
| Note to all,
| 
| I merged e100 into 2.5.x to get it some wider testing and feedback.  The
| driver currently has several PCI posting bugs particularly, and other
| outstanding bugs that need zapping before the driver will be considered
| stable.
| 
| DO NOT USE THIS DRIVER IN PRODUCTION.
| 
| After these bugs are fixed and it has received wider testing and
| feedback, only then will it be merged into the stable 2.4.x series.
| 
| I recommend all vendors avoid this driver, for the moment.  It is for
| developers, testers, and early adopters only.  It should be ok for
| normal use, but edge cases are not yet zapped.
| 
| </PSA>
| 
| -- 
| Jeff Garzik      | Usenet Rule #2 (John Gilmore): "The Net interprets
| Building 1024    | censorship as damage and routes around it."
| MandrakeSoft     |
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
