Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292021AbSBYRYi>; Mon, 25 Feb 2002 12:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292036AbSBYRYa>; Mon, 25 Feb 2002 12:24:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37900 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291194AbSBYRWo>; Mon, 25 Feb 2002 12:22:44 -0500
Date: Mon, 25 Feb 2002 09:20:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rusty Russell <rusty@rustcorp.com.au>, <mingo@elte.hu>,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Lightweight userspace semaphores...
In-Reply-To: <E16fOyE-0005Xl-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0202250919580.4567-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Feb 2002, Alan Cox wrote:
>
> As opposed to adding special cases to the kernel which are unswappable and
> stand to tangle up bits of the generic vfs - eg we would have a vma with
> a vm_file but that file would not be in the dcache ?

Why should they be unswappable?

It's the same thing as giving a -1 to mmap. That doesn't make it
unswappable.

		Linus

