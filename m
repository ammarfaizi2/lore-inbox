Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262721AbTDASVO>; Tue, 1 Apr 2003 13:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262726AbTDASVO>; Tue, 1 Apr 2003 13:21:14 -0500
Received: from hera.cwi.nl ([192.16.191.8]:39066 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262721AbTDASVM>;
	Tue, 1 Apr 2003 13:21:12 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 1 Apr 2003 20:32:33 +0200 (MEST)
Message-Id: <UTC200304011832.h31IWXl19935.aeb@smtp.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, hch@infradead.org
Subject: Re: 64-bit kdev_t - just for playing
Cc: Andries.Brouwer@cwi.nl, Joel.Becker@oracle.com, Wim.Coekaerts@oracle.com,
       ahu@ds9a.nl, greg@kroah.com, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why do we need a split at all?

Inside the kernel? No need at all.
But the Unix API is in terms of major,minor.

The NFS specification talks about major,minor.
The ISO 9660 (RockRidge) standard talks about major,minor.
Etc.

Inside the kernel we can do whatever we want, and no split
is required. In userspace such a split definitely exists.

See also mknod(1) and ls(1).

Andries
