Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279922AbRKIPEA>; Fri, 9 Nov 2001 10:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279920AbRKIPDu>; Fri, 9 Nov 2001 10:03:50 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49026 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279913AbRKIPDn>;
	Fri, 9 Nov 2001 10:03:43 -0500
Date: Fri, 09 Nov 2001 07:03:12 -0800 (PST)
Message-Id: <20011109.070312.88700201.davem@redhat.com>
To: manfred@colorfullife.com
Cc: jakub@redhat.com, bcrl@redhat.com, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, arjanv@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] take 2 of the tr-based current
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BEBEE0B.BA1FD7EE@colorfullife.com>
In-Reply-To: <20011108211143.A4797@redhat.com>
	<20011109041327.T4087@devserv.devel.redhat.com>
	<3BEBEE0B.BA1FD7EE@colorfullife.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Manfred Spraul <manfred@colorfullife.com>
   Date: Fri, 09 Nov 2001 15:54:03 +0100

   Jakub Jelinek wrote:
   > If TR register only ever changes during cpu_init, I don't see why you
   > cannot use const.
   
   The task register is only pure, not const.

As far as what the compiler can see or care about, it is
const.

Franks a lot,
David S. Miller
davem@redhat.com
