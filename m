Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135364AbRDSUCw>; Thu, 19 Apr 2001 16:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135578AbRDSUCk>; Thu, 19 Apr 2001 16:02:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33551 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135364AbRDSUCa>; Thu, 19 Apr 2001 16:02:30 -0400
Subject: Re: [linux-lvm] Re: [repost] Announce: Linux-OpenLVM mailing list
To: lewis@sistina.com (AJ Lewis)
Date: Thu, 19 Apr 2001 21:03:24 +0100 (BST)
Cc: linux-lvm@sistina.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        jes@linuxcare.com (Jes Sorensen), linux-kernel@vger.kernel.org,
        linux-openlvm@nl.linux.org, arjanv@redhat.com (Arjan van de Ven),
        axboe@suse.de (Jens Axboe), mkp@linuxcare.com (Martin Kasper Petersen),
        riel@conectiva.com.br
In-Reply-To: <20010419145337.K10345@sistina.com> from "AJ Lewis" at Apr 19, 2001 02:53:37 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qKeF-0007wb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As far as getting patches into the stock kernel, we've been sending patches
> to Linus for over a month now, and none of them have made it in.  Maybe
> someone has some pointers on how we get our code past his filters.

Has it occured to you that some of this might be because the code does stuff
like hide flags in the low bits of addresses and do unchecked kmallocs ?
Things people have tried to send patches for ..

The best way to get stuff to Linus is to feed him changes one at a time and
make them all clean and clearly correct. When I have a big set of changes I
normally start by feeding Linus all the 'fluff' - spelling checks and small
warning fixes. After that its normally easy to pick out changes one at a time
and feed them on.

Given 500 lines of mixed up diff it is very hard to verify the correctness of
anything. 

Alan

