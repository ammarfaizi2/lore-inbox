Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269875AbRHNTQN>; Tue, 14 Aug 2001 15:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269866AbRHNTP4>; Tue, 14 Aug 2001 15:15:56 -0400
Received: from quattro.sventech.com ([205.252.248.110]:61191 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S269875AbRHNTPv>; Tue, 14 Aug 2001 15:15:51 -0400
Date: Tue, 14 Aug 2001 12:29:19 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Jes Sorensen <jes@sunsite.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Determine if card is in 32 or 64 bit PCI slot?
Message-ID: <20010814122919.G3126@sventech.com>
In-Reply-To: <20010808161703.Q21901@sventech.com> <E15UaNj-00062K-00@the-village.bc.nu> <20010808165919.R21901@sventech.com> <d3elqe63g2.fsf@lxplus015.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <d3elqe63g2.fsf@lxplus015.cern.ch>; from jes@sunsite.dk on Tue, Aug 14, 2001 at 05:55:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001, Jes Sorensen <jes@sunsite.dk> wrote:
> >>>>> "Johannes" == Johannes Erdfelt <johannes@erdfelt.com> writes:
> 
> Johannes> On Wed, Aug 08, 2001, Alan Cox <alan@lxorguk.ukuu.org.uk>
> Johannes> wrote:
> >> Are you sure the card actually needs this. Most such cards support
> >> dual address cycle, so when placed in a 32bit slot will still do
> >> 64bit DMA
> 
> Johannes> No I don't know if it's needed. I had no idea that PCI could
> Johannes> do that.
> 
> Johannes> Is dual address cycle mandated by the PCI specs?
> 
> According to the PCI spec "The master is required in all cases to use
> two clocks to communicate a 64-bit address, since the width of a
> target's bus is not known during the address phase."
> 
> Aka, the answer to your question is yes.

Ahh, excellent. Thank you very much.

JE

