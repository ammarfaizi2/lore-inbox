Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289366AbSBXDTz>; Sat, 23 Feb 2002 22:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292789AbSBXDTq>; Sat, 23 Feb 2002 22:19:46 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:28534 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S289366AbSBXDTe>; Sat, 23 Feb 2002 22:19:34 -0500
Date: Sun, 24 Feb 2002 03:19:47 +0000
From: Adam Huffman <bloch@verdurin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Boot problem with PDC20269
Message-ID: <20020224031947.A1098@bloch.verdurin.priv>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020223205342.C2603@bloch.verdurin.priv> <Pine.LNX.4.30.0202232200290.13755-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.30.0202232200290.13755-100000@mustard.heime.net>; from roy@karlsbakk.net on Sat, Feb 23, 2002 at 22:02:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Feb 2002, Roy Sigurd Karlsbakk wrote:

> > > er .. I'm running a PDC20269 with a few drives. Is that supposed to be
> > > impossible?
> > >
> > > roy
> > >
> >
> > May I ask which kernel you are running?
> 
> linux-2.4.18pre3 + tux + linuxdiskcert.org's ide_2.4.17 patch
> --
> Roy Sigurd Karlsbakk, Datavaktmester
> 

I've managed to boot successfully now with 2.4.18-rc2-ac2.

I get the following messages when I mount the IBM 60GXP:

hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
PDC202XX: Primary channel reset.
ide2: reset: success

but mounting does proceed.  No such problem with the Maxtor.

Adam
