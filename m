Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261625AbTCaNGg>; Mon, 31 Mar 2003 08:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261630AbTCaNGg>; Mon, 31 Mar 2003 08:06:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41872 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261625AbTCaNGc>;
	Mon, 31 Mar 2003 08:06:32 -0500
Date: Mon, 31 Mar 2003 05:14:14 -0800 (PST)
Message-Id: <20030331.051414.40786962.davem@redhat.com>
To: sfr@canb.auug.org.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, randolph@tausq.org
Subject: Re: [PATCH][COMPAT] fix for net/compat.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030331163625.733559b7.sfr@canb.auug.org.au>
References: <20030331163625.733559b7.sfr@canb.auug.org.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Rothwell <sfr@canb.auug.org.au>
   Date: Mon, 31 Mar 2003 16:36:25 +1000

   This is basically a patch from Randolph Chung who tells me that when
   a syscall is done from the kernel, you cannot pass user mode pointers
   to it on some architectures.  So we need to copy the sock_filter
   array into kernel space before we pass it to the real system call.
  ... 
   Please apply.

Applied, thanks.
