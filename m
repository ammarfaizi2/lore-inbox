Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277568AbRJMR2J>; Sat, 13 Oct 2001 13:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277578AbRJMR17>; Sat, 13 Oct 2001 13:27:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23563 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277568AbRJMR1w>; Sat, 13 Oct 2001 13:27:52 -0400
Date: Sat, 13 Oct 2001 10:28:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul McKenney <Paul.McKenney@us.ibm.com>
cc: <dipankar@beaverton.ibm.com>, <linux-kernel@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <Pine.LNX.4.33.0110131015410.8707-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0110131024480.8707-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 Oct 2001, Linus Torvalds wrote:
>
> In short, RCU seems to be a case of "hey, that's cool", but it's a
> solution in search of a problem so severe that it is worth it.

Oh, and before people start telling me that RCU was successfully used in
AIX/projectX/xxxx/etc, you have to realize that I don't give a rats *ss
about the fact that there are OS's out there that are "more scalable".

The last time I looked, Solaris and AIX and all the rest of the "scalable"
systems were absolute pigs on smaller hardware, and the "scalability" in
them often translates into "we scale linearly to many CPU's by being
really bad even on one".

		Linus

