Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSESVpu>; Sun, 19 May 2002 17:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSESVpt>; Sun, 19 May 2002 17:45:49 -0400
Received: from grande.dcc.unicamp.br ([143.106.7.8]:41093 "EHLO
	grande.dcc.unicamp.br") by vger.kernel.org with ESMTP
	id <S315260AbSESVpt>; Sun, 19 May 2002 17:45:49 -0400
Date: Sun, 19 May 2002 18:45:40 -0300 (EST)
From: ULISSES FURQUIM FREIRE DA SILVA <ra993482@ic.unicamp.br>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hardware, IDE or ext3 problem?
In-Reply-To: <20020519221117.A17385@bouton.inet6-interne.fr>
Message-ID: <Pine.GSO.4.10.10205191810420.17205-100000@tigre.dcc.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you had reliable UDMA before and not now, e-mail me the details of your
> last known working kernel/kernel config.

	Hmm.. my last kernel was a 2.2.17 and I remember of seeing
'*udma2' in the output of `hdparm -i`.. but I don't have the kernel config
file. :-( Does this mean I had UDMA??

> I was not expecting this. Isn't `hdparm -i` supposed to check the current dma
> mode with an asterisk? It evens checks the last used dma mode (at least
> here) when dma is turned off. Guess I shouldn't have `rm -rf`ed the hdparm
> source...

	I thought the current dma mode was checked with an asterisk too..
	`hdparm -i /dev/hdb` output shows:
	
	[...]
	DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2
	AdvancedPM=no

	I'm confused.. Should I change my cables? Is there any risk to use
my drive?

-- Ulisses

