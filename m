Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271612AbRIBMqq>; Sun, 2 Sep 2001 08:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271614AbRIBMqg>; Sun, 2 Sep 2001 08:46:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43527 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271612AbRIBMq0>; Sun, 2 Sep 2001 08:46:26 -0400
Subject: Re: [RFC] lazy allocation of struct block_device
To: viro@math.psu.edu (Alexander Viro)
Date: Sun, 2 Sep 2001 13:49:37 +0100 (BST)
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <Pine.GSO.4.21.0109020719220.21487-100000@weyl.math.psu.edu> from "Alexander Viro" at Sep 02, 2001 07:38:53 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15dWgz-00081K-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not an option for any tree I'd ever run on my box and IIRC Linus was not
> likely to inflict that on his.  As for the glibc...
> 	a) not everything uses this piece of shit
> 	b) it would be really nice to get rid of it completely someday

In the userspace world the 64bit dev_t doesn't show up in anyones profiles
its an unusual opaque cookie compare, or a cast (and the cast case gcc
generates nice code for anyway). 

Alan
