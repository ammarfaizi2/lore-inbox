Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281874AbRLOEIe>; Fri, 14 Dec 2001 23:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281893AbRLOEIY>; Fri, 14 Dec 2001 23:08:24 -0500
Received: from mx2.elte.hu ([157.181.151.9]:32152 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S281880AbRLOEIM>;
	Fri, 14 Dec 2001 23:08:12 -0500
Date: Sat, 15 Dec 2001 07:05:45 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: William Irwin <willir@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] bootmem for 2.5
In-Reply-To: <20011102140207.V31822@w-wli.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0112150701180.22884-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Nov 2001, William Irwin wrote:

> [...] According to testing, this patch appears to save somewhere
> between 8KB and 2MB on i386 PC's versus the bitmap-based bootmem
> allocator.

exactly where do these savings come from? The bootmem allocator frees its
bitmaps in free_all_bootmem().

	Ingo

