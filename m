Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312891AbSDOQBg>; Mon, 15 Apr 2002 12:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312894AbSDOQBf>; Mon, 15 Apr 2002 12:01:35 -0400
Received: from 24-25-196-177.san.rr.com ([24.25.196.177]:3855 "HELO
	acmay.homeip.net") by vger.kernel.org with SMTP id <S312891AbSDOQBf>;
	Mon, 15 Apr 2002 12:01:35 -0400
Date: Mon, 15 Apr 2002 09:01:33 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Jens Axboe <axboe@suse.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, "Ivan G." <ivangurdiev@yahoo.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 compile bugs
Message-ID: <20020415090133.C30578@ecam.san.rr.com>
In-Reply-To: <20020415115131.GN12608@suse.de> <Pine.LNX.4.21.0204151356070.26237-100000@serv> <20020415120927.GO12608@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 02:09:27PM +0200, Jens Axboe wrote:
> In my mind these are generic functions, it's a shame that they come with
> a pci_ prefix and take a pci dev as first argument (the NULL for isa
> seems like a kludge).

arch/ppc/mm/cachemap.c has the function consistent_alloc() for getting
uncached mem for non-PCI use. I don't know about the other arch's.

But we could expect the other arch's to provide the same function.
