Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129379AbRBOORH>; Thu, 15 Feb 2001 09:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbRBOOQ5>; Thu, 15 Feb 2001 09:16:57 -0500
Received: from nic-31-c31-100.mn.mediaone.net ([24.31.31.100]:35200 "EHLO
	nic-31-c31-100.mn.mediaone.net") by vger.kernel.org with ESMTP
	id <S129379AbRBOOQw>; Thu, 15 Feb 2001 09:16:52 -0500
Date: Thu, 15 Feb 2001 08:16:15 -0600 (CST)
From: "Scott M. Hoffman" <scott@mediaone.net>
X-X-Sender: <scott@nic-31-c31-100.mn.mediaone.net>
Reply-To: <scott1021@mediaone.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.2-pre3 segfaults and Oops
In-Reply-To: <Pine.LNX.4.32.0102140928001.4339-300000@nic-31-c31-100.mn.mediaone.net>
Message-ID: <Pine.LNX.4.32.0102150806360.2526-100000@nic-31-c31-100.mn.mediaone.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Scott M. Hoffman wrote:

> Hello,
>    See the attached Oops passed through ksymoops 2.3.7(the i386 rpm from
> kernel.org).  Not sure who should see this...
>    Is it generally a good idea to reboot the machine after getting one of
> these?
>
I've been trying to see if this was a hardware problem (see my post about
memtest86 crashing on me five out of five times at the same point).
  Even after rebooting from this Oops, I was still getting Segfaults from
several programs.
  Going back to 2.4.1, it seems fine.  I ran several tests with bonnie++,
first without dma, or irq_unmask enabled for both /dev/hda and /dev/hdb.
Then with dma, then with dma and irq_unmask enabled(as usually have it).
No Segfaults, no Ooops...yet :)
  I didn't do any of the above tests in 2.4.2-pre3, as my system just
seemed unstable.  If there is an indication that it's not my machine being
flaky, I'd be glad to test further, in hope of being able to use 2.4.2.

Thanks,
Scott

