Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261796AbRESMKo>; Sat, 19 May 2001 08:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261793AbRESMKe>; Sat, 19 May 2001 08:10:34 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:51618 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S261786AbRESMKO>; Sat, 19 May 2001 08:10:14 -0400
Message-ID: <3B0661AA.A2D6933B@uow.edu.au>
Date: Sat, 19 May 2001 22:06:02 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Andries.Brouwer@cwi.nl, bcrl@redhat.com, torvalds@transmeta.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion codein  
 userspace
In-Reply-To: <3B065C78.C20BBCA@uow.edu.au> <Pine.GSO.4.21.0105190750380.5339-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
>  It's way past ugly.

I knew you'd like it.

It kind of makes sense, because it puts the two primary stream-of-bytes
objects in Unix into the same namespace, with the same accessors.
So if some random application is expecting a filename well heck, you
just give it a path-to-executable with args.  It won't care, although
it may have trouble lseek()ing on it.

It wasn't very serious at all.

-
