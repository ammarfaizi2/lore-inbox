Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269811AbRHNL1S>; Tue, 14 Aug 2001 07:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269965AbRHNL1I>; Tue, 14 Aug 2001 07:27:08 -0400
Received: from ns.suse.de ([213.95.15.193]:14084 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S269811AbRHNL0y>;
	Tue, 14 Aug 2001 07:26:54 -0400
Date: Tue, 14 Aug 2001 13:26:56 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Tim Hockin <thockin@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <alan@redhat.com>, <torvalds@transmeta.com>
Subject: Re: [PATCH] nvram driver work
In-Reply-To: <3B78A38D.CBA72401@sun.com>
Message-ID: <Pine.LNX.4.30.0108141324060.29900-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001, Tim Hockin wrote:

Hi Tim,

> This patch does 4 main things:
> 1) Add generic support for paged nvrams, and supporting ioctls
> 2) Add a 'Magic' page for system-specific NVRAM-like things
> 3) Add support for NatSemi PC[89]7317 paged nvram
> 4) Add support for Cobalt's magic page

No problem with that stuff.

> It also does some re-formatting of things that looked awful with tabstops >
> 2.

With the tabstops set to the value defined at the bottom of the file (4)
it looks fine. Your changes break the indentation of the rest of the
file when viewed as it was originally created.

> We've been using this patch for months.  Please apply it to the next 2.4.x
> kernel, or let me know if you have problems with it.  It is against 2.4.8
> and should patch cleanly (just a bit of fuzz).

line 116 needs changing also, to by 128-RTC_FIRST_BYTE

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

