Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154538AbQDKL6d>; Tue, 11 Apr 2000 07:58:33 -0400
Received: by vger.rutgers.edu id <S154460AbQDKL6N>; Tue, 11 Apr 2000 07:58:13 -0400
Received: from lightning.swansea.uk.linux.org ([194.168.151.1]:14964 "EHLO the-village.bc.nu") by vger.rutgers.edu with ESMTP id <S153923AbQDKL54>; Tue, 11 Apr 2000 07:57:56 -0400
Subject: Re: zap_page_range(): TLB flush race
To: sct@redhat.com (Stephen C. Tweedie)
Date: Tue, 11 Apr 2000 12:56:59 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), kanoj@google.engr.sgi.com (Kanoj Sarcar), manfreds@colorfullife.com (Manfred Spraul), linux-kernel@vger.rutgers.edu, linux-mm@kvack.org, torvalds@transmeta.com, davem@redhat.com
In-Reply-To: <20000410232149.M17648@redhat.com> from "Stephen C. Tweedie" at Apr 10, 2000 11:21:49 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E12ezHx-0007RL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-kernel@vger.rutgers.edu

> What exactly do different architectures need which set_pte() doesn't 
> already allow them to do magic in?  

Some of them need a valid PTE to exist in order to flush a page from cache
to memory



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
