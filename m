Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKONUG>; Wed, 15 Nov 2000 08:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQKONT4>; Wed, 15 Nov 2000 08:19:56 -0500
Received: from [62.172.234.2] ([62.172.234.2]:5176 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129097AbQKONTs>;
	Wed, 15 Nov 2000 08:19:48 -0500
Date: Wed, 15 Nov 2000 12:50:16 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: test11-pre5 _completely_ broken?
Message-ID: <Pine.LNX.4.21.0011151246390.1567-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

The test11-pre5 seems to be unusable:

o starting up vim(1) takes many seconds instead of the usual <<1 second

o trying to strace vim takes even longer

o trying to ltrace vim panics the kernel but kdb is also unusable -- can't
  decode stack traces etc. Perhaps I'll go back to non-kdb kernel and hope
  to at least get a decent oops out of it (maybe Linus was right ;)

I will come back with more info. Oh btw, this is on a 4-way Xeon with 6G
RAM. But my desktop (2xPIII with 1G RAM) works with test11-pre5 just fine
for ages (since 1am last night), without any problem (of course vim starts
fast as it should).

Regards,
Tigran


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
