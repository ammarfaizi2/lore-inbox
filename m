Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130901AbQKRCJx>; Fri, 17 Nov 2000 21:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131022AbQKRCJn>; Fri, 17 Nov 2000 21:09:43 -0500
Received: from raven.toyota.com ([205.180.183.200]:56848 "EHLO
	raven.toyota.com") by vger.kernel.org with ESMTP id <S130901AbQKRCJ1>;
	Fri, 17 Nov 2000 21:09:27 -0500
Message-ID: <3A15DDCB.42B0F208@toyota.com>
Date: Fri, 17 Nov 2000 17:39:23 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: test11-pre7 compile failure
In-Reply-To: <Pine.LNX.4.10.10011171720410.5987-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a quick heads-up -

looks like the md fixes broke something -

In file included from /usr/src/linux/include/linux/pagemap.h:17,
                 from /usr/src/linux/include/linux/locks.h:9,
                 from /usr/src/linux/include/linux/raid/md.h:37,
                 from init/main.c:25:
/usr/src/linux/include/linux/highmem.h: In function `bh_kmap':
/usr/src/linux/include/linux/highmem.h:23: structure has no member named
`p_page'
In file included from /usr/src/linux/include/linux/raid/md.h:51,
                 from init/main.c:25:
/usr/src/linux/include/linux/raid/md_k.h: In function `pers_to_level':
/usr/src/linux/include/linux/raid/md_k.h:39: warning: control reaches end of
non-void function
make: *** [init/main.o] Error 1


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
