Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266693AbSKUO4i>; Thu, 21 Nov 2002 09:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266702AbSKUO4i>; Thu, 21 Nov 2002 09:56:38 -0500
Received: from kim.it.uu.se ([130.238.12.178]:11992 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S266693AbSKUO4i>;
	Thu, 21 Nov 2002 09:56:38 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15836.62923.176208.289682@kim.it.uu.se>
Date: Thu, 21 Nov 2002 16:03:39 +0100
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Andi Kleen <ak@suse.de>, Margit Schubert-While <margit@margit.com>,
       linux-kernel@vger.kernel.org
Subject: Re: L1_CACHE_SHIFT value for P4 ?
In-Reply-To: <20021121132302.GD9883@suse.de>
References: <4.3.2.7.2.20021121130236.00b15370@mail.dns-host.com.suse.lists.linux.kernel>
	<p73y97nt6fp.fsf@oldwotan.suse.de>
	<20021121132302.GD9883@suse.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes:
 > On Thu, Nov 21, 2002 at 02:10:02PM +0100, Andi Kleen wrote:
 > 
 >  > The P4 has 128byte L2 cache lines (2^7). The L1 apparently has smaller lines.
 > 
 > Not mine:
 > 
 > L2 unified cache:
 > 	Size: 512KB	Sectored, 8-way associative.
 > 	line size=64 bytes.
 > 
 > Someone (Manfred?) pointed out a chapter in the P4 system programmer guide about
 > this last time I brought it up. I forget the reasoning, I'll see if I can dig it out..

The info is in the P4 Code Optimization manual. I don't have it handy,
but as I recall, the P4s have 64 byte sectors and read two sectors on
a read miss. I don't know what happens on writes.

/Mikael
