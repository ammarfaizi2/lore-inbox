Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276906AbRJKUpY>; Thu, 11 Oct 2001 16:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276907AbRJKUpP>; Thu, 11 Oct 2001 16:45:15 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:38418 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S276906AbRJKUpK>; Thu, 11 Oct 2001 16:45:10 -0400
Date: Thu, 11 Oct 2001 22:43:43 +0200
From: Christian Ullrich <chris@chrullrich.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] Can't mount reiserfs with 2.4.11, 2.4.10 works fine
Message-ID: <20011011224343.B730@christian.chrullrich.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011011061239.A990@christian.chrullrich.de> <3BC55363.ABE2813B@namesys.com> <20011011200349.A3818@christian.chrullrich.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
In-Reply-To: <20011011200349.A3818@christian.chrullrich.de>; from chris@chrullrich.de on Thu, Oct 11, 2001 at 08:03:49PM +0200
X-Current-Uptime: 0 d, 00:02:05 h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Ullrich wrote on Thursday, 2001-10-11:

> * Vladimir V. Saveliev wrote on Thursday, 2001-10-11:

> > Have you tried to run badblocks under 2.4.10 and 2.4.11?

> I just did under 2.4.10. No trouble at all.

With 2.4.11, it says "bad blocks range 0-0" and doesn't 
test anything else, that is, it takes no time at all.
I just found that my earlier "trouble-free" badblocks run
under 2.4.10 wasn't as trouble-free as I thought:

christian kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c01292d6
christian kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0) from c01292d6
christian kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c01292d6
christian last message repeated 2 times
christian last message repeated 3 times
christian kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c01292d6
christian kernel: __alloc_pages: 0-order allocation failed (gfp=0xf0/0) from c01292d6
christian kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c01292d6
christian last message repeated 2 times
christian kernel: __alloc_pages: 0-order allocation failed (gfp=0xf0/0) from c01292d6
christian kernel: __alloc_pages: 0-order allocation failed (gfp=0xf0/0) from c01292d6
christian kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c01292d6
christian kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c01292d6
christian kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c01292d6
christian last message repeated 2 times
christian kernel: __alloc_pages: 0-order allocation failed (gfp=0xf0/0) from c01292d6
christian kernel: __alloc_pages: 5-order allocation failed (gfp=0x1f0/0) from c01292d6
christian last message repeated 2 times

>From System.map:

c01292c0 T _alloc_pages
c01292e0 t balance_classzone

Thank you very much for your help.

-- 
Christian Ullrich		     Registrierter Linux-User #125183

"Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"
