Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbRASJrq>; Fri, 19 Jan 2001 04:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130348AbRASJrh>; Fri, 19 Jan 2001 04:47:37 -0500
Received: from shaker.worfie.net ([203.8.161.33]:17935 "HELO mail.worfie.net")
	by vger.kernel.org with SMTP id <S129881AbRASJrU>;
	Fri, 19 Jan 2001 04:47:20 -0500
Date: Fri, 19 Jan 2001 17:47:14 +0800 (WST)
From: "J.Brown (Ender/Amigo)" <ender@enderboi.com>
X-X-Sender: <ender@shaker.worfie.net>
To: <linux-kernel@vger.kernel.org>
Subject: Continuing OOP's...
Message-ID: <Pine.LNX.4.31.0101191743150.4110-100000@shaker.worfie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Testing with newer kernels, I'm still getting these kernel OOP's and
memory allocation issues with saving large file names that I reported a
while ago.

In particualar, saving files over 32 chars in length to a HFS partiton. In
2.2, no problems. The name would truncate and everything is happy.

Under 2.4.x(pre x), I get "Illegal Instruction", OOP's, and general system
instability.

Is this more likely to be a kernel issue or HFS driver issue? Anyone know
who's maintaining that this millenium? :p

Regards,
	 Ender
 _________________________ ______________________________
|   James 'Ender' Brown   | "Where are we going, and why |
| http://www.enderboi.com |  am I in this handbasket?!?" |
+-------------------------+------------------------------+


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
