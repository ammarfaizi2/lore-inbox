Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <155052-19607>; Fri, 22 Jan 1999 09:23:13 -0500
Received: by vger.rutgers.edu id <154679-19607>; Fri, 22 Jan 1999 08:28:37 -0500
Received: from slip139-92-91-241.tel.il.ibm.net ([139.92.91.241]:1160 "HELO hexagon.org" ident: "qmailr") by vger.rutgers.edu with SMTP id <154221-19608>; Fri, 22 Jan 1999 07:37:09 -0500
Message-ID: <19990122144223.A1812@hexagon>
Date: Fri, 22 Jan 1999 14:42:23 +0200
From: Nimrod Zimerman <zimerman@deskmail.com>
To: Linux Kernel mailing list <linux-kernel@vger.rutgers.edu>
Subject: Re: arca-vm-26
Mail-Followup-To: Linux Kernel mailing list <linux-kernel@vger.rutgers.edu>
References: <36A76D5C.379635A2@packetengines.com> <Pine.LNX.3.96.990121205408.1387G-100000@laser.bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <Pine.LNX.3.96.990121205408.1387G-100000@laser.bogus>; from Andrea Arcangeli on Thu, Jan 21, 1999 at 08:56:12PM +0100
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, Jan 21, 1999 at 08:56:12PM +0100, Andrea Arcangeli wrote:

> > I do not wish to start a religious war about data structures.  Have you considered
> > the relatively new data structure called a 'skip list'?  I have replaced several
> 
> Never heard about them.

Pretty nice beasts. When I learned about them, I didn't quite consider them
a better alternative to various trees, but I guess smarter people (smarter
people with more time) have studied them extensively enough to show that
they are indeed a better choice at times.

The implementation is indeed simple. Far simpler than any self-balancing
tree (tough one has to admit that writing a B+ tree implementation is an
endless source of fun). Analyzing the complexity, at least in the variant
I've learned, isn't all that straight forward, as the algorithm is
probabilistic.

Anyway, a reference 'on the web' is http://wannabe.guru.org/alg/node35.html
(it is a very extensive reference of various algorithms. A must keep in your
bookmark file if your bank account doesn't look all that good...). I just
saw that it has a reference to the original paper presenting the data
structure, and this might make an interesting reading.

                                                   Nimrod

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
