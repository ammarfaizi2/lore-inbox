Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268371AbRGZRZc>; Thu, 26 Jul 2001 13:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268275AbRGZRZV>; Thu, 26 Jul 2001 13:25:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32783 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267750AbRGZRZJ>; Thu, 26 Jul 2001 13:25:09 -0400
Subject: Re: Weird ext2fs immortal directory bug (all-in-one)
To: wingc@engin.umich.edu (Christopher Allen Wing)
Date: Thu, 26 Jul 2001 18:25:47 +0100 (BST)
Cc: sentry21@cdslash.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0107261312450.6405-100000@bayarea.engin.umich.edu> from "Christopher Allen Wing" at Jul 26, 2001 01:21:01 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PotP-0004AG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> I am assuming that the problem here was that fsck restored a lost inode to
> lost+found, but the inode had been corrupted and had the immutable bit
> set.

Which would actually be an fsck bug, since such an inode isnt legal and cant
be fixed by normal means
 
