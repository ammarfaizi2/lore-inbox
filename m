Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265452AbRGGXUv>; Sat, 7 Jul 2001 19:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265463AbRGGXUl>; Sat, 7 Jul 2001 19:20:41 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:54535 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S265452AbRGGXUa>; Sat, 7 Jul 2001 19:20:30 -0400
Date: Sat, 7 Jul 2001 16:20:30 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: <linux-kernel@vger.kernel.org>
Subject: TCP_DEFER_ACCEPT
Message-ID: <Pine.LNX.4.33.0107071615440.10441-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i was digging around for info on TCP_DEFER_ACCEPT and found this claim in
the thttpd mailing list archive:

> Alexey Kuznestov mentioned to me that on SMP servers, this option may
> not be desired as it creates a new contention point

is this still the case?

i haven't played with it yet, but i was going to add it to apache-2.0's
portability layer (which already has freebsd's SO_ACCEPTFILTER support).
is this one of those cases where kernel gurus would prefer me to put it
into apache-2.0 and turn it on regardless of the current performance
'cause you guys think you can fix it?

(lately i'm playing only with non-SMP boxes, and my viewpoint is kind of
biased :)

-dean


