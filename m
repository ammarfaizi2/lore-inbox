Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278385AbRJMTqd>; Sat, 13 Oct 2001 15:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278383AbRJMTqU>; Sat, 13 Oct 2001 15:46:20 -0400
Received: from quechua.inka.de ([212.227.14.2]:14624 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S278382AbRJMTqQ>;
	Sat, 13 Oct 2001 15:46:16 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Corrupt ext2/ext3 directory entries not recovered by e2fsck
In-Reply-To: <17469.1002977074@ocs3.intra.ocs.com.au>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.10-xfs (i686))
Message-Id: <E15sUkB-0000Zu-00@calista.inka.de>
Date: Sat, 13 Oct 2001 21:46:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <17469.1002977074@ocs3.intra.ocs.com.au> you wrote:
> I am surprised that neither ext3 recovery nor e2fsck detected the
> broken directory entries.  Before I clri the directory entry, does
> anybody want more details?

I had problems (the first for years) with 2.4.11-xfs, too. I had illegal
chars in file names in my ext2 /home partition. But e2fsck was able to clear
them. It was due to a kernel oops caused by openafs module.

Not sure if it is related.

Greetings
Bernd
