Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270647AbRHNSjD>; Tue, 14 Aug 2001 14:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270645AbRHNSix>; Tue, 14 Aug 2001 14:38:53 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:49078 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S270631AbRHNSin>;
	Tue, 14 Aug 2001 14:38:43 -0400
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Determine if card is in 32 or 64 bit PCI slot?
In-Reply-To: <20010808161703.Q21901@sventech.com> <E15UaNj-00062K-00@the-village.bc.nu> <20010808165919.R21901@sventech.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 14 Aug 2001 17:55:57 +0200
In-Reply-To: Johannes Erdfelt's message of "Wed, 8 Aug 2001 16:59:19 -0400"
Message-ID: <d3elqe63g2.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Johannes" == Johannes Erdfelt <johannes@erdfelt.com> writes:

Johannes> On Wed, Aug 08, 2001, Alan Cox <alan@lxorguk.ukuu.org.uk>
Johannes> wrote:
>> Are you sure the card actually needs this. Most such cards support
>> dual address cycle, so when placed in a 32bit slot will still do
>> 64bit DMA

Johannes> No I don't know if it's needed. I had no idea that PCI could
Johannes> do that.

Johannes> Is dual address cycle mandated by the PCI specs?

According to the PCI spec "The master is required in all cases to use
two clocks to communicate a 64-bit address, since the width of a
target's bus is not known during the address phase."

Aka, the answer to your question is yes.

Jes
