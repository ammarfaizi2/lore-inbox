Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269254AbRHTUjj>; Mon, 20 Aug 2001 16:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269250AbRHTUj3>; Mon, 20 Aug 2001 16:39:29 -0400
Received: from [213.4.18.231] ([213.4.18.231]:11538 "EHLO fulanito.nisupu.com")
	by vger.kernel.org with ESMTP id <S269238AbRHTUjY>;
	Mon, 20 Aug 2001 16:39:24 -0400
Message-ID: <006d01c129b8$1957f2c0$0414a8c0@10>
From: =?iso-8859-1?Q?Carlos_Fern=E1ndez_Sanz?= 
	<cfs-lk@fulanito.nisupu.com>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: select(), EOF...
Date: Mon, 20 Aug 2001 22:38:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry if this is a dupe, I haven't seen it come from the list, so I'm
resending as plain ASCII in case majordomo kills messages with strange
stuff)

Hi,

I need to do something similar to tail -f.
I was hoping that select() or poll() would block my process after reaching
EOF but (as the man says) EOF doesn't cause read() to block so select() and
poll() both say I can read. The result is (obviously) that my program waits
actively and uses all the CPU.
What's the right way of doing this? I assume the kernel provides facilities
to find out if there is new data to read (other than EOF).

Thanks.

