Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSJ1WxW>; Mon, 28 Oct 2002 17:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261662AbSJ1WxW>; Mon, 28 Oct 2002 17:53:22 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:34769 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261660AbSJ1WxA>; Mon, 28 Oct 2002 17:53:00 -0500
Subject: Re: [PATCHSET 4/23] add support for PC-9800 architecture (core #1)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20021029023003.A2241@precia.cinet.co.jp>
References: <20021029023003.A2241@precia.cinet.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Oct 2002 23:18:07 +0000
Message-Id: <1035847087.1945.105.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-28 at 17:30, Osamu Tomita wrote:
> This is a part 4/23 of patchset for add support NEC PC-9800 architecture,
> against 2.5.44.

Ok I've merged bits from this. I redid the vm86 patches by moving the
checks and the range limit into arch/i386/mach-*/irq_vector.h which I
think is tidier, and hopefully still correct.


