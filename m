Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143391AbREKUN2>; Fri, 11 May 2001 16:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143383AbREKUNS>; Fri, 11 May 2001 16:13:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29851 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S143378AbREKUNE>;
	Fri, 11 May 2001 16:13:04 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15100.18375.367656.3591@pizda.ninka.net>
Date: Fri, 11 May 2001 13:12:55 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mauelshagen@sistina.com,
        linux-kernel@vger.kernel.org, mge@sistina.com
Subject: Re: LVM 1.0 release decision
In-Reply-To: <20010511171124.M30355@athlon.random>
In-Reply-To: <20010511162745.B18341@sistina.com>
	<E14yDyI-0000yE-00@the-village.bc.nu>
	<20010511171124.M30355@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > I just switched to the >=beta4 lvm IOP for all 64bit archs. The previous
 > one (the 2.4 mainline one) isn't feasible on the archs with 32bit
 > userspace and 64bit kernel (it uses long). The IOP didn't changed btw,
 > only the structures changed silenty.

They can be converted, there is in fact initial sparc64 code to
handle the existing LVM ioctls in arch/sparc64/kernel/ioctl32.c

Without argument, the LVM ioctls are done in such a way that
conversion is a bit difficult, but not entirely impossible.

Later,
David S. Miller
davem@redhat.com
