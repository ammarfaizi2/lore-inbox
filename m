Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154140AbPGUUyJ>; Wed, 21 Jul 1999 16:54:09 -0400
Received: by vger.rutgers.edu id <S154285AbPGUUvE>; Wed, 21 Jul 1999 16:51:04 -0400
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:36094 "HELO tsx-prime.MIT.EDU") by vger.rutgers.edu with SMTP id <S154302AbPGUUlQ>; Wed, 21 Jul 1999 16:41:16 -0400
Date: Wed, 21 Jul 1999 16:41:08 -0400
Message-Id: <199907212041.QAA10609@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Lars Kellogg-Stedman <lars@bu.edu>
CC: Nomad the Wanderer <nomad@orci.com>, linux-kernel <linux-kernel@vger.rutgers.edu>
In-reply-to: Lars Kellogg-Stedman's message of Wed, 21 Jul 1999 15:26:33 -0400 (EDT), <Pine.GSO.4.03.9907211520330.12022-100000@csa.bu.edu>
Subject: Re: Device naming???
Address: 1 Amherst St., Cambridge, MA 02139
Phone: (617) 253-8091
Sender: owner-linux-kernel@vger.rutgers.edu

The other solution for avoiding problems if a specific SCSI drive fails
to spin up is to use entries in /etc/fstab of the following form:

LABEL=tmp              /tmp                     ext2    defaults 1 2
UUID=3a30d6b4-08a5-11d3-91c3-e1fc5550af17  /usr ext2    defaults 1 2

The latest mount supports this, as does the very latest e2fsprogs
release (1.15, just released this week; see the e2fsprogs page at
http://web.mit.edu/tytso/www/linux/e2fsprogs.html).

						- Ted


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
