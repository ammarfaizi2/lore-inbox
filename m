Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262045AbSKCPEk>; Sun, 3 Nov 2002 10:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262042AbSKCPEk>; Sun, 3 Nov 2002 10:04:40 -0500
Received: from quechua.inka.de ([193.197.184.2]:983 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S262046AbSKCPEj>;
	Sun, 3 Nov 2002 10:04:39 -0500
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.LNX.4.44.0211021754180.2300-100000@home.transmeta.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E188MPA-0006w2-00@sites.inka.de>
Date: Sun, 3 Nov 2002 16:11:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0211021754180.2300-100000@home.transmeta.com> you wrote:
> So I'd suggest _not_ attaching that capability to the sendmail binary
> itself, or to any inode number of that binary. A binary is a binary is a
> binary - it's just the data. Instead, I'd attach the information to the
> directory entry, either directly (ie the directory entry really has an
> extra field that lists the capabilities) or indirectly (ie the directory
> entry is really just an "extended symlink" that contains not just the path
> to the binary, but also the capabilities associated with it).

If you modify the object you need to find all attached labels to downgrade
it's capabilities. Therefore you need to find a way from the object to the
capabilities stored in various entries.

Greetings
Bernd
