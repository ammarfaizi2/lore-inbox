Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263160AbRFGVKU>; Thu, 7 Jun 2001 17:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263173AbRFGVKK>; Thu, 7 Jun 2001 17:10:10 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:27632 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S263160AbRFGVKG>; Thu, 7 Jun 2001 17:10:06 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200106072109.f57L9FeW005798@webber.adilger.int>
Subject: Re: Background scanning change on 2.4.6-pre1
In-Reply-To: <Pine.LNX.4.21.0106071545520.1156-100000@freak.distro.conectiva>
 "from Marcelo Tosatti at Jun 7, 2001 03:50:31 pm"
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Date: Thu, 7 Jun 2001 15:09:15 -0600 (MDT)
CC: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcello writes:
> Who did this change to refill_inactive_scan() in 2.4.6-pre1 ? 
> 
>         /*
>          * When we are background aging, we try to increase the page aging
>          * information in the system.
>          */
>         if (!target)
>                 maxscan = nr_active_pages >> 4;

A quick check in the l-k archives shows this was Zlatko Calusic
<zlatko.calusic@iskon.hr> who submitted the patch.  See

http://marc.theaimsgroup.com/?l=linux-kernel&m=99151955000988&w=4

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
