Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282747AbRK0Cmk>; Mon, 26 Nov 2001 21:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282748AbRK0Cma>; Mon, 26 Nov 2001 21:42:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35855 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282747AbRK0CmU>; Mon, 26 Nov 2001 21:42:20 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Journaling pointless with today's hard disks?
Date: 26 Nov 2001 18:41:35 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tuugv$f72$1@cesium.transmeta.com>
In-Reply-To: <200111270123.BAA02056@mauve.demon.co.uk> <0111261800340R.02001@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <0111261800340R.02001@localhost.localdomain>
By author:    Rob Landley <landley@trommello.org>
In newsgroup: linux.dev.kernel
>
> On Monday 26 November 2001 20:23, Ian Stirling wrote:
> 
> > > Now a cache large enough to hold 2 full tracks could also hold dozens of
> > > individual sectors scattered around the disk, which could take a full
> > > second to write off and power down.  This is a "doctor, it hurts when I
> > > do this" question.  DON'T DO THAT.
> >
> > Or, to seek to a journal track, and write the cache to it.
> 
> Except that at most you have one seek to write out all the pending cache data 
> anyway, so what exactly does seeking to a journal track buy you?
> 

It limits the amount you need to seek to exactly one seek.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
