Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293560AbSCGO30>; Thu, 7 Mar 2002 09:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292978AbSCGO3I>; Thu, 7 Mar 2002 09:29:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61966 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292920AbSCGO2v>; Thu, 7 Mar 2002 09:28:51 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Thu, 7 Mar 2002 14:43:03 +0000 (GMT)
Cc: yodaiken@fsmlabs.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        jdike@karaya.com (Jeff Dike), bcrl@redhat.com (Benjamin LaHaise),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <E16iylp-00038V-00@starship.berlin> from "Daniel Phillips" at Mar 07, 2002 03:21:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iz6l-0002St-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since there is always at least one freeable page in the system (or we're oom) then
> we just have to find it and we know we can forcibly unmap it.  We do need to know
> the total of pinned pages, I should have said locked/dirty/pinned.

What if I did a 4 page allocation ?

And if we are OOM - we want to return NULL
