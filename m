Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSFJPLA>; Mon, 10 Jun 2002 11:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315451AbSFJPK7>; Mon, 10 Jun 2002 11:10:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60170 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315449AbSFJPK6>; Mon, 10 Jun 2002 11:10:58 -0400
Date: Mon, 10 Jun 2002 08:11:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <3D045B85.16136535@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0206100810380.30336-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Jun 2002, Helge Hafting wrote:
>
> Not much, but
> ls /dev/net
> eth0 eth1 eth2 ippp0
> would be a convenient way to see what net devices exists.
> This already works for other devices, when using devfs.

You might as well do

	cat /proc/net/dev

instead.

Which works with existing kernels, going back to whatever..

		Linus

