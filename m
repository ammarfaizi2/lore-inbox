Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271597AbRIROpL>; Tue, 18 Sep 2001 10:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271619AbRIROpA>; Tue, 18 Sep 2001 10:45:00 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21254 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271597AbRIROov>; Tue, 18 Sep 2001 10:44:51 -0400
Subject: Re: Deadlock on the mm->mmap_sem
To: dhowells@redhat.com (David Howells)
Date: Tue, 18 Sep 2001 15:49:11 +0100 (BST)
Cc: manfred@colorfullife.com (Manfred Spraul),
        andrea@suse.de (Andrea Arcangeli),
        torvalds@transmeta.com (Linus Torvalds), dhowells@redhat.com,
        Ulrich.Weigand@de.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <5552.1000822425@warthog.cambridge.redhat.com> from "David Howells" at Sep 18, 2001 03:13:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jMBT-00011x-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Okay preliminary as-yet-untested patch to cure coredumping of the need> to 
>hold the mm semaphore:

If you want codd for this its in the older -ac tree. Linus decided it wasnt
justified so it went out
