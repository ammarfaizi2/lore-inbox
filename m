Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288944AbSA0Wpm>; Sun, 27 Jan 2002 17:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288964AbSA0Wpa>; Sun, 27 Jan 2002 17:45:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27915 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288944AbSA0WpL>; Sun, 27 Jan 2002 17:45:11 -0500
Subject: Re: Preempt & how long it takes to interrupt (was Re: [2.4.17/18pre]u
To: nigel@nrg.org
Date: Sun, 27 Jan 2002 22:56:50 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), landley@trommello.org (Rob Landley),
        pavel@suse.cz (Pavel Machek), helgehaf@aitel.hist.no (Helge Hafting),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0201271357050.8324-100000@cosmic.nrg.org> from "Nigel Gamble" at Jan 27, 2002 02:10:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16UyEE-0002zV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You could make the same argument against SMP, but Linux has SMP support
> despite all the thousands of SMP flaws that once lurked with no obvious
> automated way to find them.  Most of them have been found.

We spent four years on that. It was also done in a very careful and 
precise manner starting with SMP that gave the same guarantees as non SMP
for the 2.0 kernel tree, then moving on to relaxing guarantees in certain
places -as they were audited- for 2.2 and with 2.4 increasing the coverage
to all major points of contention except the scsi layer

> I have a patch to do this for earlier versions of the kernel preemption
> patch - I need to bring it up to date and send it to Robert for use with
> the latest versions of his patch.

Nod - thats a productive approach

