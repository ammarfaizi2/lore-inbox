Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272020AbRHVOoW>; Wed, 22 Aug 2001 10:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272016AbRHVOoM>; Wed, 22 Aug 2001 10:44:12 -0400
Received: from sweetums.bluetronic.net ([24.162.254.3]:1466 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S272021AbRHVOoD>; Wed, 22 Aug 2001 10:44:03 -0400
Date: Wed, 22 Aug 2001 10:44:14 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Qlogic/FC firmware
In-Reply-To: <E15ZYNZ-0001Yc-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.33.0108220951530.6389-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Alan Cox wrote:
>> Amazing *and* unnecessarily complex.  What a bargin!  And it's still going
>> to consume that precious 128K even when loaded from usersapce as the driver
>> will still need to keep it.  And aren't you one of the Preists of Text in
>
>No. We can jettison it and you know that in fact you commented on using
>__initdata in the non modular case, so stop trolling and if you are going to
>be a pain, at least be consistant in your arguments.

I'm missing the "in the case of sparc" clause.  The sparc (and maybe others?)
have to keep the firmware image in memory in the case that it needs to reload
the sequencer.  The initrd simply adds more tool-chains to keep up-to-date.
Any distribution supporting the Qlogic,FC will have to supply a firmware file
in binary form to initialize the card.  And then you're right back to square
one in the binary distribution arena.

--Ricky


