Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbTCQIVr>; Mon, 17 Mar 2003 03:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262598AbTCQIVr>; Mon, 17 Mar 2003 03:21:47 -0500
Received: from quechua.inka.de ([193.197.184.2]:28864 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S261644AbTCQIVq>;
	Mon, 17 Mar 2003 03:21:46 -0500
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: FileSystem XFS vs RiserFS vs ext3
In-Reply-To: <3E7556C2.7030000@thizgroup.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.14-20020917 ("Chop Suey!") (UNIX) (Linux/2.4.18-xfs (i686))
Message-Id: <E18uq2v-0004P7-00@calista.inka.de>
Date: Mon, 17 Mar 2003 09:32:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3E7556C2.7030000@thizgroup.com> you wrote:
> Hi all I get basic understanding of the functions and different between
> XFS, RiserFS and ext3. But in high volumn read write enviornment (database,
> NFS email server etc), which will provide better preformance?

NFS is a bit tricky. Reiser used to be broken on it, and at least from large
XFS NFS Servers I know that they tend to be unstable, still.

For the Database Servers, I am not sure how well they operate with
journaling filesystems. I think Linux Journal had an article on performance
on that.

Reiser might be your bet, depending on the usage pattern of the filename
space, with Ext3 catching up. Personally I love the XFS features for
resizing in connection with LVMs, but i guess you can have that with Ext3
and Reiser, too.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
