Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbRBORBX>; Thu, 15 Feb 2001 12:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129382AbRBORBN>; Thu, 15 Feb 2001 12:01:13 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43271 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129250AbRBORBB>; Thu, 15 Feb 2001 12:01:01 -0500
Subject: Re: Linux 2.4.1ac14
To: david@fortyoz.org
Date: Thu, 15 Feb 2001 17:00:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010215085238.A14932@fortyoz.org> from "David Raufeisen" at Feb 15, 2001 08:52:38 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14TRlv-0000DG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After building/playing around with some java apps on this version, something
> seems to have gone weird with X or the kernel..
> 
> david@prototype:~$ ps aux | grep X
> root       267  0.9 99.9 167640 4294965764 ? S<   06:50   1:11 /usr/bin/X11/X vt7 -auth /var/lib/gdm/:0.Xauth :0
> 
> System seems mostly fine, a bit slow..

Yeah folks were wondering if our rss accounting was atomically safe. I guess
the answer from this one is 'probably not'

> Would having the huge swap have anything to do with it? Needed it to install
> oracle, but the blasted thing won't install anyway (Debian Sid).

It actually looks like the system is working fine other than miscounting the
resident size of the X process.

Rik, Ben ?

