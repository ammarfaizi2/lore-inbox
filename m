Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273949AbRIXPj4>; Mon, 24 Sep 2001 11:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273940AbRIXPjq>; Mon, 24 Sep 2001 11:39:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47113 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273949AbRIXPjf>; Mon, 24 Sep 2001 11:39:35 -0400
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Mon, 24 Sep 2001 16:45:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <20010924173210.A7630@emma1.emma.line.org> from "Matthias Andree" at Sep 24, 2001 05:32:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15lXup-0002uj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > better. Decent write caching on IDE devices (like the 2meg buffer on the IBM) 
> > can completely hide this issue.
> 
> Decent write caching on IDE devices can eat your whole file system.

YM bad write caching 8)

> Turn it off (I have no idea of internals, but I presume it'll still be a
> write-through cache, so reading back will still be served from the
> buffer). Do hdparm -W0 /dev/hd[a-h].

You can't turn it off and on many drives you can't flush the cache either
the operation is not implemented.
