Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290720AbSBLCiI>; Mon, 11 Feb 2002 21:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290736AbSBLCh6>; Mon, 11 Feb 2002 21:37:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17799 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290720AbSBLChu>;
	Mon, 11 Feb 2002 21:37:50 -0500
Date: Mon, 11 Feb 2002 18:36:03 -0800 (PST)
Message-Id: <20020211.183603.111204707.davem@redhat.com>
To: davidm@hpl.hp.com
Cc: anton@samba.org, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: thread_info implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15464.32354.452126.182563@napali.hpl.hp.com>
In-Reply-To: <15464.30088.754007.311391@napali.hpl.hp.com>
	<20020211.182208.102575913.davem@redhat.com>
	<15464.32354.452126.182563@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@hpl.hp.com>
   Date: Mon, 11 Feb 2002 18:30:58 -0800
   
   So why don't you share the results?  Perhaps then I can see the light,
   too.  With the exception of task coloring, the thread_info is strictly
   more work and it's possible to do task coloring without thread_info.

All performance tests I ran were "about the same" on sparc64, on x86
we really only have one anomaly on one of Linus's SMP x86 machines
(fork+exec from lmbench on dual-Athlon) and I'm going to push to
investigate that further.
