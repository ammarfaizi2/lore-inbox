Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277606AbRJHX3B>; Mon, 8 Oct 2001 19:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277607AbRJHX2v>; Mon, 8 Oct 2001 19:28:51 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12804 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277606AbRJHX2j>; Mon, 8 Oct 2001 19:28:39 -0400
Subject: Re: [PATCH] change name of rep_nop
To: davej@suse.de (Dave Jones)
Date: Tue, 9 Oct 2001 00:33:43 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davem@redhat.com (David S. Miller),
        dwmw2@infradead.org, frival@zk3.dec.com, paulus@samba.org,
        Martin.Bligh@us.ibm.com, torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        jay.estabrook@compaq.com, rth@twiddle.net
In-Reply-To: <Pine.LNX.4.30.0110090120540.5479-100000@Appserv.suse.de> from "Dave Jones" at Oct 09, 2001 01:24:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qju3-0002I6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How do you propose to do this without turning setup.c and friends
> into a #ifdef nightmare ? setup_intel.c, setup_amd.c etc ??

By leaving well alone. That is all init and non runtime overhead. Things
like lock addl $0, (%esp) all through the code are not.
