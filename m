Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbTF3Wcx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 18:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbTF3Wcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 18:32:53 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:56812 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265970AbTF3Wct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 18:32:49 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] patch-O1int-0306302317 for 2.5.73 interactivity
Date: Tue, 1 Jul 2003 08:50:36 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200307010029.19423.kernel@kolivas.org> <Pine.LNX.4.53.0306301405230.2299@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.53.0306301405230.2299@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307010850.36040.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jul 2003 04:27, Zwane Mwaikambo wrote:
> On Tue, 1 Jul 2003, Con Kolivas wrote:
> > Buried deep in another mail thread was the latest implementation of my
> > O1int patch so I've brought it to the surface to make it clear this one
> > is significantly different from past iterations.
> >
> > Summary:
> > Decreases audio skipping with loads.
> > Smooths out X performance with load.
>
> I tried this with normal developer box type load on a slow box ie;
>
> 2x 400MHz 512MB source/build fs' on UW2 SCSI
> kernel: 2.5.72-mm3
>
> 2x make -j2 bzImage
> bk pull (linux-2.5 repo)
> cvs import of 2.5 tree
> navigating bk revtool (this normally causes pauses)
> read disk benchmark just to thrash IDE about a bit ;)
>
> Still a few MP3 pauses (due to bk revtool mainly) but mouse/keyboard
> response was good, there is however a vast improvement over 2.5.73
> stock (2-5s pauses with no keyboard/mouse response) for my particular
> workload.

Thanks for testing and working with me.

Please if others are testing and still having problems note this work is _not_ 
complete yet, but I do need to assess every incremental change to make sure 
it addresses the issue I am trying to fix at each step.

For what it's worth there are still at least 3 things I need to 
implement/change in this patch which induce problems still, so tell me of 
your experiences and I will try hard to accomodate.

Con

