Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131091AbQLIVzw>; Sat, 9 Dec 2000 16:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131863AbQLIVzm>; Sat, 9 Dec 2000 16:55:42 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2308 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131091AbQLIVzX>;
	Sat, 9 Dec 2000 16:55:23 -0500
Message-ID: <20001209222427.A1542@bug.ucw.cz>
Date: Sat, 9 Dec 2000 22:24:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: swapoff weird
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It is possible to remove swapfile in use. Great, but how do you swap
off then? Who is to blame?

root@bug:~# swapoff /tmp/swap
swapoff: /tmp/swap: No such file or directory
root@bug:~# > /tmp/swap
root@bug:~# swapoff /tmp/swap
swapoff: /tmp/swap: Invalid argument
root@bug:~#

How do I get out of this bad situation?
							Pavel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
