Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289813AbSCRRCX>; Mon, 18 Mar 2002 12:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSCRRCD>; Mon, 18 Mar 2002 12:02:03 -0500
Received: from colino.net ([62.212.100.143]:11005 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id <S289813AbSCRRCB>;
	Mon, 18 Mar 2002 12:02:01 -0500
Date: Mon, 18 Mar 2002 18:01:58 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Subject: question about 2.4.18 and ext3
Message-Id: <20020318180158.2886dd4a.colin@colino.net>
Organization: Colino Computing
X-Mailer: Sylpheed version 0.7.4claws21 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I really hope I'm not asking a FAQ, i looked in the archives since 15 Feb
and didn't see anything about this.

I upgraded from 2.2.20 to 2.4.18 on my powerbook two weeks ago, and
compiled ext3 in the kernel in order to quietly crash :)

However, I had about a dozen strange crashes, sometimes when the computer
woke up from sleep, sometimes when launching a program : every visible
soft died, then X, then blackscreen, and the computer didn't even answer
pings. So I reset the computer and here, each time, yaboot (ppc equivalent
of lilo) told me that "cannot load image". Booting and fscking from a
rescue CD showed that superblock was corrupt. 

Of course, nothing in any log :-/
I went back to ext2 three days ago and I do not suffer any crashes since.

Is there a problem with ext3 on 2.3.18 ?
Thanks,
-- 
Colin
