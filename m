Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269536AbRHHU73>; Wed, 8 Aug 2001 16:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269541AbRHHU7U>; Wed, 8 Aug 2001 16:59:20 -0400
Received: from quattro.sventech.com ([205.252.248.110]:24849 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S269536AbRHHU7I>; Wed, 8 Aug 2001 16:59:08 -0400
Date: Wed, 8 Aug 2001 16:59:19 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Determine if card is in 32 or 64 bit PCI slot?
Message-ID: <20010808165919.R21901@sventech.com>
In-Reply-To: <20010808161703.Q21901@sventech.com> <E15UaNj-00062K-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E15UaNj-00062K-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Aug 08, 2001 at 09:56:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > I have a 64 bit PCI card which will work in either a 32 bit or 64 bit
> > PCI slot.
> > 
> > I'd like to make the driver autodetect which kind of slot the card is
> > in and set the dma_mask correctly, but I can't seem to figure out how to
> > do this.
> 
> Are you sure the card actually needs this. Most such cards support dual address
> cycle, so when placed in a 32bit slot  will still do 64bit DMA

No I don't know if it's needed. I had no idea that PCI could do that.

Is dual address cycle mandated by the PCI specs?

JE

