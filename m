Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282967AbSASOvP>; Sat, 19 Jan 2002 09:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284144AbSASOvI>; Sat, 19 Jan 2002 09:51:08 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:59845 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S282967AbSASOut>; Sat, 19 Jan 2002 09:50:49 -0500
Message-Id: <200201191450.g0JEoi75002538@tigger.cs.uni-dortmund.de>
To: Miquel van Smoorenburg <miquels@cistron.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors 
In-Reply-To: Message from Miquel van Smoorenburg <miquels@cistron.nl> 
   of "Sat, 19 Jan 2002 00:50:24 GMT." <a2afsg$73g$2@ncc1701.cistron.net> 
Date: Sat, 19 Jan 2002 15:50:44 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg <miquels@cistron.nl> said:

[...]

> There is no way to recreate a file with a nlink count of 0,
> well that is until someone adds flink(fd, newpath) to the kernel.

It stays around under /proc/<pid>/fd/<xxx>, so you could grab it there. It
is _announced_ as a symlink to the deleted file, but you get its contents
anyway. [2.4.18pre4]
-- 
Horst von Brand			     http://counter.li.org # 22616
