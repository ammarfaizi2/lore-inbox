Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129041AbRBJWVJ>; Sat, 10 Feb 2001 17:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbRBJWU7>; Sat, 10 Feb 2001 17:20:59 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:28925 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129041AbRBJWU4>; Sat, 10 Feb 2001 17:20:56 -0500
Date: Sat, 10 Feb 2001 20:20:27 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dag Wieers <dag@mind.be>, linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbols for wavelan_cs in 2.4.1-ac9
In-Reply-To: <E14RfiI-0002AB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0102102019410.2378-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2001, Alan Cox wrote:

> > I noticed a single unresolved symbol in wavelan_cs.o and I fixed it as
> > described below.
> 
> Rejected. It is meant not to be there.

To be more specific ... __bad_udelay() is meant to be an
unresolvable symbol, which is referenced when people call
udelay with a "wrong" timeout.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
