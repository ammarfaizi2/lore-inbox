Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbUK3NHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUK3NHK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 08:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbUK3NHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 08:07:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:50844 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262063AbUK3NHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 08:07:03 -0500
Subject: Re: [PATCH][2/2] ide-tape: small cleanups - handle  
	copy_to|from_user() failures
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Gadi Oxman <gadio@netvision.net.il>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0411300018240.3389@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0411281731050.3389@dragon.hygekrogen.localhost>
	 <Pine.LNX.4.61.0411281731050.3389@dragon.hygekrogen.localhost>
	 <1101663266.16761.43.camel@localhost.localdomain>
	 <41ABA6EE.6080502@tmr.com>
	 <Pine.LNX.4.61.0411300018240.3389@dragon.hygekrogen.localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101816200.25603.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 12:03:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-29 at 23:23, Jesper Juhl wrote:
> Alan: Would you mind explaining why this is not safe? If there's something 
> I'm missing I'd really like to know.

Wrong question. Prove it is safe.

Otherwise you are risking errors in critical devices (think backups) for
the sake of fixing an essentially irrelevant limitation.

