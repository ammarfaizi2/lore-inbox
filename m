Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261806AbRE3Sf4>; Wed, 30 May 2001 14:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261807AbRE3Sfq>; Wed, 30 May 2001 14:35:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53254 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261806AbRE3Sfb>; Wed, 30 May 2001 14:35:31 -0400
Subject: Re: Athlon fast_copy_page revisited
To: mayfield+kernel@sackheads.org (Jimmie Mayfield)
Date: Wed, 30 May 2001 19:33:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010530110817.A12364@sackheads.org> from "Jimmie Mayfield" at May 30, 2001 11:08:18 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155AmZ-0006NL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> schemes in user-space but if I try in kernel space, I get the notorious crash inside
> fast_copy_page.  (If there was some sort of fundamental hardware problem associated with
> prefetch or streaming, wouldn't it also show up in user-space?)  Note: I've yet to try the 

That has been one of the great puzzles. There are patterns that are very
different in kernel space - notably physically linear memory and code running
from a 4Mb tlb.

Alan

