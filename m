Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132370AbRDJW0x>; Tue, 10 Apr 2001 18:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132400AbRDJW0n>; Tue, 10 Apr 2001 18:26:43 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:29700 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S132370AbRDJW0b>;
	Tue, 10 Apr 2001 18:26:31 -0400
Date: Tue, 10 Apr 2001 19:16:06 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Phil Oester <phil@theoesters.com>, Jeff Lessem <Jeff.Lessem@Colorado.EDU>,
        linux-kernel@vger.kernel.org
Subject: Re: kswapd, kupdated, and bdflush at 99% under intense IO
In-Reply-To: <E14n6G4-0005JO-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0104101906211.25737-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2001, Alan Cox wrote:

> > Any time I start injecting lots of mail into the qmail queue, *one* of the
> > two processors gets pegged at 99%, and it takes forever for anything typed
> > at the console to actually appear (just as you describe).  But I don't see
> 
> Yes I've seen this case. Its partially still a mystery

I've seen it too.  It could be some interaction between kswapd
and bdflush ... but I'm not sure what the exact cause would be.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

