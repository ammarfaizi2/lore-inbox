Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130110AbQLHA4Q>; Thu, 7 Dec 2000 19:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131675AbQLHA4G>; Thu, 7 Dec 2000 19:56:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16910 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130110AbQLHAz7>; Thu, 7 Dec 2000 19:55:59 -0500
Subject: Re: Linux 2.2.18pre25
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 8 Dec 2000 00:27:58 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20001208012052.A23992@inspiron.random> from "Andrea Arcangeli" at Dec 08, 2000 01:20:52 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144BOL-0003Eg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Such bug can't generate crashes. Did you ever reproduced crashes on your 8Mb
> 486 with 2.2.18pre24?

Yes. Every 20 minutes or so quite reliably. With that change it has yet to 
crash (its actually running that + page aging + another minor tweak so it
doesnt return success on page aging until we have a clump of free pages.

With just the page aging patch it performed way better but still hung.

> ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.18pre24aa1/00_account-failed-buffer-tries-1
>

Oh well ;) 
 
> account-failed-buffer-tries-1 is included in VM-global-7 and it was
> described in the 2.2.18pre21aa2 email to l-k (CC'ed you) in date Fri, 17 Nov
> 2000 18:54:43 +0100:

The problem is its hard to know which of your patches depend on what, and
the complete set is large to say the least.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
