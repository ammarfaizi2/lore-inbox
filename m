Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbQKIPV1>; Thu, 9 Nov 2000 10:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129186AbQKIPVS>; Thu, 9 Nov 2000 10:21:18 -0500
Received: from selene.educ.disi.unige.it ([130.251.152.1]:52402 "EHLO
	selene.educ.disi.unige.it") by vger.kernel.org with ESMTP
	id <S129132AbQKIPVF>; Thu, 9 Nov 2000 10:21:05 -0500
Date: Thu, 9 Nov 2000 17:20:22 +0200 (GMT+0200)
From: Andrea Pintori <1997s112@educ.disi.unige.it>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.2.17 bug found
Message-ID: <Pine.LNX.3.91.1001109171915.5142B-100000@aries>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've a Debian dist, Kernel 2.2.17, no patches, all packages are stable.

here what I found:

[/tmp] mkdir old
[/tmp] chdir old
[/tmp/old] mv . ../new
[/tmp/old]                    (should be /tmp/new !!)
[/tmp/old] mkdir fff
error: cannot write...
[tmp/old] ls > fff
error: cannot write...
[/tmp/old] ls -la
total 0                         (?)
[/tmp/old] cd ..
[/tmp] ls -la
*****************       ./
*****************       ../
*****************       new/

Does anybody knew this bug?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
