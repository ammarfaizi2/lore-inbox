Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbRLJEZO>; Sun, 9 Dec 2001 23:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286162AbRLJEZF>; Sun, 9 Dec 2001 23:25:05 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:48367 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S286161AbRLJEZA>; Sun, 9 Dec 2001 23:25:00 -0500
Date: Sun, 9 Dec 2001 20:16:12 -0800
From: Chris Wright <chris@wirex.com>
To: Zilvinas Valinskas <zvalinskas@carolina.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre{7,8} fails to link
Message-ID: <20011209201612.B27109@figure1.int.wirex.com>
Mail-Followup-To: Zilvinas Valinskas <zvalinskas@carolina.rr.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011210030320.GA1621@clt88-175-140.carolina.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011210030320.GA1621@clt88-175-140.carolina.rr.com>; from zvalinskas@carolina.rr.com on Sun, Dec 09, 2001 at 10:03:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zilvinas Valinskas (zvalinskas@carolina.rr.com) wrote:
> drivers/net/net.o(.data+0x174): undefined reference to `local symbols in
> discarded section .text.exit'
> make[1]: *** [vmlinux] Error 1
> 
> $ gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
> gcc version 2.95.4 20011006 (Debian prerelease)
> 
> $ ld -v
> GNU ld version 2.11.92.0.12.3 20011121 Debian/GNU Linux

you might want to check the archives, people have been reporting that
downgrading your debian binutils gets around this problem.

cheers,
-chris
