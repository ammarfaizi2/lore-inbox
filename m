Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129730AbRBASlM>; Thu, 1 Feb 2001 13:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130866AbRBASlC>; Thu, 1 Feb 2001 13:41:02 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:12528 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129730AbRBASkn>; Thu, 1 Feb 2001 13:40:43 -0500
Date: Thu, 1 Feb 2001 16:39:32 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Christoph Hellwig <hch@caldera.de>, "Stephen C. Tweedie" <sct@redhat.com>,
        bsuparna@in.ibm.com, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
 /notify + callback chains
In-Reply-To: <E14OOQ2-0004nq-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0102011637420.1321-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Alan Cox wrote:

> > Now one could say: just let the networkers use their own kind of buffers
> > (and that's exactly what is done in the zerocopy patches), but that again leds
> > to inefficient buffer passing and ungeneric IO handling.

	[snip]
> It is quite possible that the right thing to do is to do
> conversions in the cases it happens.

OTOH, somehow a zero-copy system which converts the zero-copy
metadata every time the buffer is handed to another subsystem
just doesn't sound right ...

(well, maybe it _is_, but it looks quite inefficient at first
glance)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
