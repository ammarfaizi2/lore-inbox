Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310323AbSCGNgG>; Thu, 7 Mar 2002 08:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310324AbSCGNf4>; Thu, 7 Mar 2002 08:35:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19214 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310323AbSCGNfr>; Thu, 7 Mar 2002 08:35:47 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: jdike@karaya.com (Jeff Dike)
Date: Thu, 7 Mar 2002 13:49:23 +0000 (GMT)
Cc: bcrl@redhat.com (Benjamin LaHaise),
        phillips@bonn-fries.net (Daniel Phillips),
        hpa@zytor.com (H. Peter Anvin), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <200203070127.UAA05891@ccure.karaya.com> from "Jeff Dike" at Mar 06, 2002 08:27:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iyGp-0002IL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> caller.  This is actually wrong because in this failure case, it effectively
> changes the semantics of GFP_USER, GFP_KERNEL, and the other blocking GFP_* 
> allocations to GFP_ATOMIC.  And that's what forced UML to segfault the 
> compilations.

GFP_KERNEL will sometimes return NULL.

