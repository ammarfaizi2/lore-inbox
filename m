Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVKTVDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVKTVDG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 16:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVKTVDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 16:03:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:22719 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750806AbVKTVDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 16:03:05 -0500
Subject: Re: [BUG] PDC20268 crashing during DMA setup on stock Debian
	2.6.12-1-powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       LKML Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <59EA4A9E-0F86-4D53-8DDD-56F6DDC6E726@mac.com>
References: <20051017005855.132266ac.akpm@osdl.org>
	 <1129536482.7620.76.camel@gaston>
	 <6DFB5723-0042-46FE-811F-BF372B068014@mac.com>
	 <204AB9A8-7701-402F-A6B9-DF455DAA2A3F@mac.com>
	 <1129760024.7620.219.camel@gaston>
	 <75FE9776-B88F-453E-9616-850097DB0138@mac.com>
	 <1129772205.7620.226.camel@gaston>
	 <59EA4A9E-0F86-4D53-8DDD-56F6DDC6E726@mac.com>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 08:00:40 +1100
Message-Id: <1132520441.6052.41.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is the only possibility that I can think of, but I'm having a  
> hard time getting enough lines of pre-BUG output.  Is there any way  
> to turn off the BUG() lines and just show the printks before that point?

There is a patch from Thibault that fixes it, it should be in 2.6.15-rc2

Ben.


