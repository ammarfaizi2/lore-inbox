Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269022AbRHBQKk>; Thu, 2 Aug 2001 12:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269091AbRHBQKb>; Thu, 2 Aug 2001 12:10:31 -0400
Received: from willow.commerce.uk.net ([213.219.35.202]:29719 "EHLO
	willow.commerce.uk.net") by vger.kernel.org with ESMTP
	id <S269038AbRHBQKN>; Thu, 2 Aug 2001 12:10:13 -0400
Date: Thu, 2 Aug 2001 17:09:58 +0100 (BST)
From: Corin Hartland-Swann <cdhs@commerce.uk.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, Jason Collins <jcollins@valinux.com>
Subject: Re: Memory Problems - CTCS/memtst
In-Reply-To: <E15SJqa-0000lu-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0108021659300.23264-100000@willow.commerce.uk.net>
Organization: Commerce Internet Ltd
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

On Thu, 2 Aug 2001, Alan Cox wrote:
> > The BIOS has an ECC logging feature, and if I understand it correctly,
> > then there /cannot/ have been any main memory errors or they would have
> > shown up in the logs. At least not any single or double-bit errors (ECC
> > corrects single-bit and detects double-bit, doesn't it?)
> 
> ALmost certainly it should have been logged. That indicates you may have
> problems elsewhere (pci bus, drivers, motherboard, processors...) or you
> might even be triggering a kernel bug.
> 
> Try a  2.2.19 kernel just out of curiousity

Tried stock 2.2.19, and still got the errors on test 2 (only).

I've just tried test 2 on another machine (with good memory) and it looks
like it's a bug in memtst rather than the detection of an error.

D'oh! Back to the drawing board...

I will experiment with file copies to see if I'm still getting memory
corruption under 2.2.19 - if I am (and considering the lack of ECC errors)
then do you think I consider that conclusive proof that there is a problem
with the CPUs or the motherboard?

I have another motherboard of the same type which I can swap out - I will
try that later on...

Thanks,

Corin

/------------------------+-------------------------------------\
| Corin Hartland-Swann   |    Tel: +44 (0) 20 7491 2000        |
| Commerce Internet Ltd  |    Fax: +44 (0) 20 7491 2010        |
| 22 Cavendish Buildings | Mobile: +44 (0) 79 5854 0027        | 
| Gilbert Street         |                                     |
| Mayfair                |    Web: http://www.commerce.uk.net/ |
| London W1K 5HJ         | E-Mail: cdhs@commerce.uk.net        |
\------------------------+-------------------------------------/



