Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129074AbQKBAH4>; Wed, 1 Nov 2000 19:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129109AbQKBAHr>; Wed, 1 Nov 2000 19:07:47 -0500
Received: from pizda.ninka.net ([216.101.162.242]:19343 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129074AbQKBAHh>;
	Wed, 1 Nov 2000 19:07:37 -0500
Date: Wed, 1 Nov 2000 15:52:39 -0800
Message-Id: <200011012352.PAA20365@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: jgarzik@mandrakesoft.com
CC: ak@suse.de, alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
In-Reply-To: <3A00AF60.37DBB956@mandrakesoft.com> (message from Jeff Garzik on
	Wed, 01 Nov 2000 19:03:44 -0500)
Subject: Re: Linux-2.4.0-test10
In-Reply-To: <Pine.LNX.4.10.10010311237430.22165-100000@penguin.transmeta.com> <E13qiR9-0008FT-00@the-village.bc.nu> <20001101093839.A16274@gruyere.muc.suse.de> <3A00AF60.37DBB956@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Wed, 01 Nov 2000 19:03:44 -0500
   From: Jeff Garzik <jgarzik@mandrakesoft.com>

   Therefore for 2.4.x, our concern is whether a particular net driver
   needs further SMP protection internally, or if rtnl_lock (a semaphore,
   not a spinlock) is sufficient.

Thanks Jeff, this is precisely what Alexey and myself have been trying
to beat into Andi's head for months now :-)

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
