Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbRG1TDK>; Sat, 28 Jul 2001 15:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbRG1TDB>; Sat, 28 Jul 2001 15:03:01 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:36358 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S266997AbRG1TCt>;
	Sat, 28 Jul 2001 15:02:49 -0400
Date: Sat, 28 Jul 2001 16:02:47 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Matthew Gardiner <kiwiunixman@yahoo.co.nz>,
        "Philip R. Auld" <pauld@egenera.com>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: binary modules (was Re: ReiserFS / 2.4.6 / Data Corruption)
In-Reply-To: <3B62E80A.C732C3F5@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33L.0107281600130.11893-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, 28 Jul 2001, Jeff Garzik wrote:
> Alan Cox wrote:
> > The Linux freevxfs module is read only currently. Veritas apparently will be
> > releasing the genuine article for Linux but binary only with all the mess
> > that entails
>
> Isn't that a violation of the GPL, to release binary modules?

Binary modules using only the interfaces exported in /proc/ksyms
are, under certain readings of the GPL, no less "infected" by the
GPL than binary programs making system calls.

This means binary only modules are ok, as long as they don't need
changes in the kernel to work.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

