Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137124AbRAHNMa>; Mon, 8 Jan 2001 08:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143598AbRAHNMU>; Mon, 8 Jan 2001 08:12:20 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:386 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S137124AbRAHNMN>; Mon, 8 Jan 2001 08:12:13 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.10.10101071938540.28661-100000@penguin.transmeta.com> 
In-Reply-To: <Pine.LNX.4.10.10101071938540.28661-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, parsley@roanoke.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Patch (repost): cramfs memory corruption fix 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jan 2001 13:11:56 +0000
Message-ID: <23514.978959516@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  Also, if you care about memory usage, you're likely to be much better
> off using ramfs rather than something like "ext2 on ramdisk". You
> won't get the double buffering. 

That'll be even more useful once we can completely configure out all 
support for block devices too.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
