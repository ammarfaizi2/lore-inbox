Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVCQVqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVCQVqy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 16:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVCQVqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 16:46:54 -0500
Received: from extgw-uk.mips.com ([62.254.210.129]:32775 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261206AbVCQVoS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 16:44:18 -0500
Date: Thu, 17 Mar 2005 21:43:02 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andrew Morton <akpm@osdl.org>, Yoichi Yuasa <yuasa@hh.iij4u.or.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch][resend] convert a remaining verify_area to access_ok (was: Re: [PATCH 2.6.11-mm1] mips: more convert verify_area to access_ok) (fwd)
Message-ID: <20050317214302.GA14882@linux-mips.org>
References: <Pine.LNX.4.62.0503162227270.2558@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503162227270.2558@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 10:35:09PM +0100, Jesper Juhl wrote:

> Around 2.6.11-mm1 Yoichi Yuasa found a user of verify_area that I had 
> missed when converting everything to access_ok. The patch below still 
> applies cleanly to 2.6.11-mm4.
> Please apply (unless of course you already picked it up back then and 
> have it in a queue somewhere :) .

Oh gosh, you actually converted the whole IRIX compatibility mess even,
amazing stomach you have :-)  I only noticed that when I just looked at
Linus' tree - after buring a few hours into cleaning those files myself -
mine are now almost free of sparse warnings.

The last instance of verify_area() in the MIPS code is now the definition
itself.

  Ralf
