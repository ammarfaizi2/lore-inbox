Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBGJK5>; Wed, 7 Feb 2001 04:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129198AbRBGJKr>; Wed, 7 Feb 2001 04:10:47 -0500
Received: from dell-pe2450-1.cambridge.redhat.com ([172.16.18.1]:9745 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S129032AbRBGJKj>; Wed, 7 Feb 2001 04:10:39 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: Your message of "Tue, 06 Feb 2001 17:45:41 PST."
             <Pine.LNX.4.10.10102061741050.2193-100000@penguin.transmeta.com>
Date: Wed, 07 Feb 2001 09:10:32 +0000
Message-ID: <22688.981537032@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds <torvalds@transmeta.com> wrote:
> Actually, I'd rather leave it in, but speed it up with the saner and
> faster
>
>	if (bh->b_size & (correct_size-1)) {

I presume that correct_size will always be a power of 2...

David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
