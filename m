Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315805AbSG3Rwg>; Tue, 30 Jul 2002 13:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSG3Rwb>; Tue, 30 Jul 2002 13:52:31 -0400
Received: from holomorphy.com ([66.224.33.161]:6835 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315856AbSG3Rwa>;
	Tue, 30 Jul 2002 13:52:30 -0400
Date: Tue, 30 Jul 2002 10:55:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
       akpm@zip.com.au, riel@conectiva.com.br, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5-rmap: VM strict overcommit
Message-ID: <20020730175514.GC25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Robert Love <rml@tech9.net>, akpm@zip.com.au, riel@conectiva.com.br,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <1026928763.1116.11.camel@sinai> <20020726103104.GA279@elf.ucw.cz> <1027694803.13428.43.camel@irongate.swansea.linux.org.uk> <20020729222052.GA15219@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020729222052.GA15219@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, someone said:
>> When the kernel grabs over 50% of RAM. Remember that includes page
>> tables. I've seen the kernel taking 35% of RAM.

On Tue, Jul 30, 2002 at 12:20:52AM +0200, Pavel Machek wrote:
> But it could happen that kernel would attempt to allocate 101% of RAM
> for page tables, right? At that even "paranoid overcommit" might be
> OOM, right?

There is already accounting for this, so it is no longer necessary to
let them fly below the kernel's radar.


Cheers,
Bill
