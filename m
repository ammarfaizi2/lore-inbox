Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318059AbSG2GXW>; Mon, 29 Jul 2002 02:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318062AbSG2GXW>; Mon, 29 Jul 2002 02:23:22 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:6038 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318059AbSG2GXV>;
	Mon, 29 Jul 2002 02:23:21 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15684.57233.856491.783516@argo.ozlabs.ibm.com>
Date: Mon, 29 Jul 2002 16:24:17 +1000 (EST)
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
In-Reply-To: <3D44C1C8.C1617A09@zip.com.au>
References: <20020728.195055.105468330.davem@redhat.com>
	<Pine.LNX.4.44.0207282048230.913-100000@home.transmeta.com>
	<3D44C1C8.C1617A09@zip.com.au>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> hmm.  ia32's do_IRQ() doesn't run do_sotfirq() any more, but the
> other architectures do.  What's up with that?

The do_softirq() call is now in irq_exit() in include/asm/hardirq.h.

Paul.
