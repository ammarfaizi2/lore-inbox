Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132169AbQL2WLs>; Fri, 29 Dec 2000 17:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132515AbQL2WLi>; Fri, 29 Dec 2000 17:11:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49802 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132169AbQL2WLT>;
	Fri, 29 Dec 2000 17:11:19 -0500
Date: Fri, 29 Dec 2000 13:23:40 -0800
Message-Id: <200012292123.NAA05899@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: markhe@veritas.com
CC: ak@suse.de, torvalds@transmeta.com, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012291533000.3592-100000@alloc.wat.veritas.com>
	(message from Mark Hemment on Fri, 29 Dec 2000 15:46:22 +0000 (GMT))
Subject: Re: test13-pre5
In-Reply-To: <Pine.LNX.4.21.0012291533000.3592-100000@alloc.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 29 Dec 2000 15:46:22 +0000 (GMT)
   From: Mark Hemment <markhe@veritas.com>

     For my development testing, I'm running a _heavily_ hacked
   kernel.  One of these hacks is to pull the wait_queue_head out of
   struct page; the waitq-heads are in a separate allocated area of
   memory, with a waitq-head pointer embedded in the page structure
   (allocated/initialised in free_area_init_core()).  This gives a
   page structure of 60bytes, giving me one free double-word to play
   with (which I'm using as a pointer to a release function).

Not something like those damn Solaris turnstiles, no please....

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
