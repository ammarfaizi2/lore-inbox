Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273462AbRIQDaT>; Sun, 16 Sep 2001 23:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273463AbRIQDaJ>; Sun, 16 Sep 2001 23:30:09 -0400
Received: from m3d.uib.es ([130.206.132.6]:63940 "EHLO m3d.uib.es")
	by vger.kernel.org with ESMTP id <S273462AbRIQD34>;
	Sun, 16 Sep 2001 23:29:56 -0400
Date: Mon, 17 Sep 2001 05:30:18 +0200 (MET)
From: Ricardo Galli <gallir@m3d.uib.es>
To: <linux-kernel@vger.kernel.org>
cc: <alan@lxorguk.ukuu.org.uk>
Subject: Re: Disk errors and Reiserfs (/proc also)
Message-ID: <Pine.LNX.4.33.0109170524140.3489-100000@m3d.uib.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thats a reiserfs property and one you'll find in pretty much any other
> fs
...
> Killing the process isnt neccessary, its been halted in its tracks. As
> to a clean shutdown - no chance. You've just hit a disk failure, the on
> disk

Not true, it's not only on ReiserFS and disk failures.


I also saw this behaviour on proc:

$ cat /proc/dri/0/vma

for example.

000  1000 15186 14534   9   0  1272  368 down   D    pts/0      0:00 cat 0/vma


In such cases, just forget that tty.

--ricardo

