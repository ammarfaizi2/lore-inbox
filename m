Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129657AbRBYTtQ>; Sun, 25 Feb 2001 14:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129659AbRBYTtG>; Sun, 25 Feb 2001 14:49:06 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:64168 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S129657AbRBYTs5>;
	Sun, 25 Feb 2001 14:48:57 -0500
Message-Id: <m14X7A1-000Ob6C@amadeus.home.nl>
Date: Sun, 25 Feb 2001 20:48:49 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: sandy@storm.ca (Sandy Harris)
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <Pine.GSO.4.21.0102251048280.25245-100000@weyl.math.psu.edu> <3A99569F.98C64B29@storm.ca>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A99569F.98C64B29@storm.ca> you wrote:

> A better approach might be to find or invent a generic compressed file system.
> Given that, you just build a compressed root, copy an image of it into ramdisk
> and let the compressed FS driver handle it from there. I suspect such a driver
> might be useful elsewhere as well. Does one exist?

cramfs is compressed but read-only, jffs has the potential to do compressed
writes as well....

Greetings,
    Arjan van de Ven
