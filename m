Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277905AbRJNXcW>; Sun, 14 Oct 2001 19:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277910AbRJNXcM>; Sun, 14 Oct 2001 19:32:12 -0400
Received: from quechua.inka.de ([212.227.14.2]:14666 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S277905AbRJNXcG>;
	Sun, 14 Oct 2001 19:32:06 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] Re: ReiserFS data corruption in very simple configuration
In-Reply-To: <20011014201907.H20001@jensbenecke.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.11-xfs (i686))
Message-Id: <E15sukH-0006IY-00@calista.inka.de>
Date: Mon, 15 Oct 2001 01:32:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011014201907.H20001@jensbenecke.de> you wrote:
> What I meant is this: AFAIK, if you exclude broken hardware, in ext2 there
> is no chance of a file that was never written to since mounting being
> corrupted on a crash

Well, you can eighter lose the file due to a broken directory (maybe you
find the missing inode in lost+found) or it can even corrupt the file due to
a ext2 software error, which is unlikely but all filesystems in development
are reported to eat files every now and then.

Greetings
Bernd
