Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277911AbRJNXhC>; Sun, 14 Oct 2001 19:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277913AbRJNXgm>; Sun, 14 Oct 2001 19:36:42 -0400
Received: from quechua.inka.de ([212.227.14.2]:17482 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S277911AbRJNXgl>;
	Sun, 14 Oct 2001 19:36:41 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Cc: debian-devel@lists.debian.org
Subject: Re: mount --bind and -o [re: nosuid/noexec/nodev handling]
In-Reply-To: <20011014185908.P1074@niksula.cs.hut.fi>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.11-xfs (i686))
Message-Id: <E15suoi-0006JL-00@calista.inka.de>
Date: Mon, 15 Oct 2001 01:37:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011014185908.P1074@niksula.cs.hut.fi> you wrote:
>> mount --bind /home/luser /home/luser
>> mount -o remount,noexec /home/luser

Thats nice! For example on Debian GNU/Linux one can mount /var with noexec
with the exceptin of /var/lib/dpkg/info/* because it contains all those
installation scripts. (Well actually, this design decision is not that nice,
but at least one can work around with your vfs mount option idea.

Greetings
Bernd
