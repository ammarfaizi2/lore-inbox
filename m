Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267033AbTAUL53>; Tue, 21 Jan 2003 06:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbTAUL53>; Tue, 21 Jan 2003 06:57:29 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:45060
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267033AbTAUL52>; Tue, 21 Jan 2003 06:57:28 -0500
Date: Tue, 21 Jan 2003 04:02:25 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Andries.Brouwer@cwi.nl
cc: alan@lxorguk.ukuu.org.uk, jim.houston@attbi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] IDE OnTrack remap for 2.5.58
In-Reply-To: <UTC200301211108.h0LB8Ad12683.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.10.10301210400220.16070-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003 Andries.Brouwer@cwi.nl wrote:

>     On Thu, 2003-01-16 at 18:14, Jim Houston wrote:
>     > I went back and looked through the patches and found that the remapping
>     > support was removed in patch-2.5.30.  The comments in the mailing list
>     > suggest that it belonged in user space.
> 
> [of course a shift cannot be done in user space]
> 
>     > I have not found code/instructions on how to do this.
>     > Since then, most of IDE code has been reverted to the
>     > 2.4 versions but not this bit.
> 
>     This was done without the involvement of the IDE maintainers.
>     Please direct complaints to Andries Brouwer. Come 2.6 the vendors
>     will all be merging it back into their trees.
> 
>     Alan
> 
> Ha, Alan -
> 
> I think both Andre and Martin were happy, but maybe you mean nobody
> asked you? Are you unhappy with this change? And if so, why?

It is a DGD to me ... but there are lots of tracking teathers (sp) for
laptops coming out and since the bios people will not share the HPA and
freeze lock it.  These folks are looking to use overlays to fake the
effects of HPA.

Cheers,


Andre Hedrick
LAD Storage Consulting Group

