Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272193AbRHWC0O>; Wed, 22 Aug 2001 22:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272190AbRHWC0E>; Wed, 22 Aug 2001 22:26:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18563 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272187AbRHWCZq>;
	Wed, 22 Aug 2001 22:25:46 -0400
Date: Wed, 22 Aug 2001 19:26:00 -0700 (PDT)
Message-Id: <20010822.192600.35357607.davem@redhat.com>
To: kevin.vanmaren@unisys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <245F259ABD41D511A07000D0B71C4CBA289F30@us-slc-exch-3.slc.unisys.com>
In-Reply-To: <245F259ABD41D511A07000D0B71C4CBA289F30@us-slc-exch-3.slc.unisys.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
   Date: Wed, 22 Aug 2001 21:22:19 -0500

   If the HW generates DAC for addresses < 4GB whenever enabling
   support for 64-bit addresses, then that is very broken.

That is what happens.
   
   Please don't complain that I didn't spend hours searching
   through the archives looking for a message from months? years? ago
   that I didn't know existed.

Weeks, if not days.
   
   > I think for SAC-only devices, it is just dumb wasted space in the
   > driver image.
   
   Perhaps.  But the question is whether it is simpler/better to have
   HIGHMEM x86 kernels (which by definition have memory to spare) waste
   a few bytes to provide "sane" interfaces across all platforms.  And
   whether the kernel bloat for all the additional functions compensates
   for it ;-)

The plain fact is that %95 of PCI devices do not support DAC
addressing.

Later,
David S. Miller
davem@redhat.com


   
