Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131473AbQKVL6e>; Wed, 22 Nov 2000 06:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131468AbQKVL6Z>; Wed, 22 Nov 2000 06:58:25 -0500
Received: from smtp2.free.fr ([212.27.32.6]:28676 "EHLO smtp2.free.fr")
	by vger.kernel.org with ESMTP id <S131473AbQKVL6G>;
	Wed, 22 Nov 2000 06:58:06 -0500
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [BUG] 2.2.1[78] : RTNETLINK lock not properly locking ?
Message-ID: <974892477.3a1badbdefd2d@imp.free.fr>
Date: Wed, 22 Nov 2000 12:27:57 +0100 (MET)
From: Willy Tarreau <willy.lkml@free.fr>
Cc: willy.lkml@free.fr, linux-kernel@vger.kernel.org
In-Reply-To: <974885943.3a1b9437847da@imp.free.fr> <200011220946.BAA07355@pizda.ninka.net>
In-Reply-To: <200011220946.BAA07355@pizda.ninka.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 195.6.58.78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "David S. Miller" <davem@redhat.com>:

>    Date: 	Wed, 22 Nov 2000 10:39:03 +0100 (MET)
>    From: Willy Tarreau <willy.lkml@free.fr>
> 
>    Thanks in advance for any comment,
> 
> All of this is protected by lock_kernel() so none of the
> A,B,C,whatever spots can be interrupted in 2.2.x

so, does this mean that rtnl_*lock* are completely useless ???

Willy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
