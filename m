Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbVKHGGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVKHGGn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 01:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbVKHGGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 01:06:43 -0500
Received: from mgate03.necel.com ([203.180.232.83]:25990 "EHLO
	mgate03.necel.com") by vger.kernel.org with ESMTP id S964907AbVKHGGm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 01:06:42 -0500
To: Willy Tarreau <willy@w.ods.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 13/20] inflate: (arch) kill silly zlib typedefs
References: <14.196662837@selenic.com>
	<Pine.LNX.4.62.0510312204400.26471@numbat.sonytel.be>
	<20051031211422.GC4367@waste.org>
	<20051101065327.GP22601@alpha.home.local>
	<Pine.LNX.4.62.0511010850190.2739@numbat.sonytel.be>
	<20051101085740.GR22601@alpha.home.local>
From: Miles Bader <miles.bader@necel.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Tue, 08 Nov 2005 15:05:57 +0900
In-Reply-To: <20051101085740.GR22601@alpha.home.local> (Willy Tarreau's message of "Tue, 1 Nov 2005 09:57:40 +0100")
Message-Id: <buowtjjsmgq.fsf@dhapc248.dev.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> writes:
> I don't know if x86_64 is LP64 or LLP64 on Linux, but at least my alpha
> and sparc64 are LP64, so is another PPC64 I use for code validation.
> LPC64 is the recommended model for easier 32 to 64 portability (where
> ints are 32 ; long, longlong, ptrs are 64).

Are there _any_ (widespread) platforms except Windows that use LLP64?

LP64 seems to be by far the most common in the unix world.

-miles
-- 
"1971 pickup truck; will trade for guns"
