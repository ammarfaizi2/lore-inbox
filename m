Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283860AbRLWHQq>; Sun, 23 Dec 2001 02:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284017AbRLWHQe>; Sun, 23 Dec 2001 02:16:34 -0500
Received: from quechua.inka.de ([212.227.14.2]:22040 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S283860AbRLWHQY>;
	Sun, 23 Dec 2001 02:16:24 -0500
From: Bernd Eckenfels <usenet2001-12@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <E16I1Yc-0003eD-00@schizo.psychosis.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E16I2rw-0006zi-00@sites.inka.de>
Date: Sun, 23 Dec 2001 08:16:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16I1Yc-0003eD-00@schizo.psychosis.com> you wrote:
> I know this, and have taken rpm's apart buy hand, and wrote 
> a small util to take them apart using cpio. I consider it a good
> example of Redhat's many screw up's. Deb's use a pair of .tgz's
> and header. Much more sane.

Well, debian is using an "ar" archive with tar.gz contents.

> How many times have you seen ANYTHING ditributed that way?

AFAIK cpio is quite common on SysV Systems. The Problem with cpio and tar is,
that there are many incompatible versions. Even the Posix.1 format is quite
limited (255 char path limit). Some others fail short with symlinks or block
device nodes.

AFAIK SUS is supporting the use of pax.

http://www.opengroup.org/onlinepubs/7908799/xcu/pax.html 

Greetings
Bernd
