Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132352AbRDJV7k>; Tue, 10 Apr 2001 17:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132359AbRDJV7b>; Tue, 10 Apr 2001 17:59:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58632 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132352AbRDJV7L>; Tue, 10 Apr 2001 17:59:11 -0400
Subject: Re: [PATCH] i386 rw_semaphores fix
To: ak@suse.de (Andi Kleen)
Date: Tue, 10 Apr 2001 23:00:31 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        dhowells@cambridge.redhat.com (David Howells),
        andrewm@uow.edu.au (Andrew Morton), bcrl@redhat.com (Ben LaHaise),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20010410220551.A24251@gruyere.muc.suse.de> from "Andi Kleen" at Apr 10, 2001 10:05:51 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14n6Be-0005Ir-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I guess 386 could live with an exception handler that emulates it.

386 could use a simpler setup and is non SMP

> (BTW an generic exception handler for CMPXCHG would also be very useful
> for glibc -- currently it has special checking code for 386 in its mutexes) 
> The 386 are so slow that nobody would probably notice a bit more slowness
> by a few exceptions.

Be serious. You can compile glibc without 386 support. Most vendors already
distribute 386/586 or 386/686 glibc sets.

