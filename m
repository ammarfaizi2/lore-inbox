Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130187AbQLIQIg>; Sat, 9 Dec 2000 11:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131682AbQLIQI0>; Sat, 9 Dec 2000 11:08:26 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:27140 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130187AbQLIQIZ>; Sat, 9 Dec 2000 11:08:25 -0500
Date: Sat, 9 Dec 2000 15:37:48 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7 
In-Reply-To: <Pine.GSO.4.21.0012081353170.27010-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0012091536130.1122-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000, Alexander Viro wrote:

> BTW, what do you think about the following:
> 	* add_to_page_cache() is not exported and never used. Kill?

I have my eye on that for execute-in-place of romfs from real ROM chips -
making up struct pages for parts of the ROM chips and inserting them into
the page cache. I'd rather you didn't remove it :)

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
