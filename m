Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129307AbQKHSr6>; Wed, 8 Nov 2000 13:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129470AbQKHSrt>; Wed, 8 Nov 2000 13:47:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38962 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129307AbQKHSrn>; Wed, 8 Nov 2000 13:47:43 -0500
Subject: Re: Pentium 4 and 2.4/2.5
To: kernel@kvack.org
Date: Wed, 8 Nov 2000 18:47:40 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        bapper@piratehaven.org (Brian Pomerantz),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1001108132530.8587A-100000@kanga.kvack.org> from "kernel@kvack.org" at Nov 08, 2000 01:27:36 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13taG6-0000JH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 8 Nov 2000, Alan Cox wrote:
> 
> > What state does it leave the condition codes ?  That matters. 
> 
> Alan, rep ; nop is one of the suggested 2 byte fillers in the Athon
> optimization guide; it's handled during instruction decode and is
> completely free.  It also has no effect on K6s.

Ok. Issue settled. So 'rep nop' is safe. Ok that can get into the spinlocks
for 2.2.18


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
