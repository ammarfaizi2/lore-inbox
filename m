Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.com) by vger.kernel.org via listexpand
	id <S261164AbRELD7r>; Fri, 11 May 2001 23:59:47 -0400
Received: (majordomo@vger.kernel.com) by vger.kernel.org
	id <S261167AbRELD7H>; Fri, 11 May 2001 23:59:07 -0400
Received: from zeus.kernel.org ([209.10.41.242]:49800 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261168AbRELD6G>;
	Fri, 11 May 2001 23:58:06 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15100.37367.477922.66043@pizda.ninka.net>
Date: Fri, 11 May 2001 18:29:27 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mauelshagen@sistina.com,
        linux-kernel@vger.kernel.org, mge@sistina.com
Subject: Re: LVM 1.0 release decision
In-Reply-To: <20010512032453.A8259@athlon.random>
In-Reply-To: <20010511162745.B18341@sistina.com>
	<E14yDyI-0000yE-00@the-village.bc.nu>
	<20010511171124.M30355@athlon.random>
	<15100.18375.367656.3591@pizda.ninka.net>
	<20010512032453.A8259@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > Related side note: for the x86-64 kernel we won't support the emulation
 > of the lvm ioctl from the 32bit executables to avoid the pointer
 > conversion an mainteinance pain enterely, at least in the early stage
 > the x86-64 lvmtools will have to be compiled elf64.

I think that's a bad decision, but it is your's.

To me, either you support fully the 32-bit execution
environment or you do not.  After all the work that
myself and others have done for other platforms, there
really is no need to cut corners in this area.

My userland on sparc64 is %100 32-bit and everything works
quite beautifully.

Later,
David S. Miller
davem@redhat.com


