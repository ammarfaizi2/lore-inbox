Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278062AbRJOTo0>; Mon, 15 Oct 2001 15:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278052AbRJOToQ>; Mon, 15 Oct 2001 15:44:16 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:54801 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S278061AbRJOToF>;
	Mon, 15 Oct 2001 15:44:05 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200110151944.f9FJiYZ01673@oboe.it.uc3m.es>
Subject: what happened to mark_buffer_protected()
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Mon, 15 Oct 2001 21:44:34 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice function. Used to use it. 2.4.8. 2.4.12-going-on-13 and it's no
longer there. No BH_Protected field in the bh either.

OK, so how do I stop buffers being reclaimed now? My intention
is to keep the buffer hanging around forever once I have written to it,
so that further reads to that block of my device return the buffer
content without ever getting to my device (that's right, write-once,
read-many).

He's off to read the ramdisk code, tara, tarum, tara ...

Peter
