Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317950AbSHUH1D>; Wed, 21 Aug 2002 03:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317978AbSHUH1D>; Wed, 21 Aug 2002 03:27:03 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:37126
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317950AbSHUH1C>; Wed, 21 Aug 2002 03:27:02 -0400
Date: Wed, 21 Aug 2002 00:30:40 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Gunther Mayer <gunther.mayer@gmx.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18-rc3aa3: dma_intr: status=0x51 errors
In-Reply-To: <3D628F90.6040301@gmx.net>
Message-ID: <Pine.LNX.4.10.10208201821490.3867-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2002, Gunther Mayer wrote:

> Andre Hedrick wrote:
> 
> >Because it is a hardware error.
> >Your drive is attempting to reallocate sectors and is failing.
> >
> The drive cannot relocate on an "uncorrectable read error",
> as this must be communicated to the user, so he can get
> the data from backup.

Gunther,

Where are we in disagreement?

me:  the error report because the drive failed to reallocate sector(s)
you: drive cannot relocate with this error.

Oh I have a noise maker patch for Erik Anderson, I just need to add it.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


