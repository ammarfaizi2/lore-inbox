Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285230AbRLFVfx>; Thu, 6 Dec 2001 16:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285224AbRLFVfn>; Thu, 6 Dec 2001 16:35:43 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:30621 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S285231AbRLFVfc>;
	Thu, 6 Dec 2001 16:35:32 -0500
Date: Thu, 6 Dec 2001 16:35:31 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Troels Walsted Hansen <troels@thule.no>, <linux-kernel@vger.kernel.org>
Subject: Re: VIA acknowledges North Bridge bug (AKA Linux Kernel with Athlon
In-Reply-To: <E16BmbY-0008DS-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0112061633550.22686-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Alan Cox wrote:

> > So does this mean we will be seeing a patch that clears bits 6,7, and 8 in
> > register 55 on the northbridge soon?
>
> We already have one. The Linux folks saw the problem much earlier than
> windows people because our athlon optimised memory copies triggered it
> reliably on many boards.
>
> Whats sad is its taken VIA this long to finally acknowledge a bug that we
> have shown existed months and months ago, and even had Linux fixes for a
> while in 2.4


There seems to be some confusion though.. I probably should just read the
code myself.. but it seems from what I've read that the patch we had
didn't clear all the bits and that maybe on the KT266, the chipset isn't
being detected as 'buggy' by the patch so nothing is being cleared... is
this correct?  If not would you mind taking the time to just tell me where
in the code I can grep for the patch?


> > Alan
>

