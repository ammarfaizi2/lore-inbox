Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267477AbSLEVRQ>; Thu, 5 Dec 2002 16:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267472AbSLEVQb>; Thu, 5 Dec 2002 16:16:31 -0500
Received: from [195.39.17.254] ([195.39.17.254]:26628 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267467AbSLEVOr>;
	Thu, 5 Dec 2002 16:14:47 -0500
Date: Thu, 5 Dec 2002 22:21:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, hubicka@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] Start of compat32.h (again)
Message-ID: <20021205212120.GA1386@elf.ucw.cz>
References: <20021202090756.GA26034@wotan.suse.de> <20021202.021629.93360250.davem@redhat.com> <20021204111947.GB309@elf.ucw.cz> <20021205.130614.99253893.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021205.130614.99253893.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    Actually, it tends to nullify the bloat cost and then make it few
>    percent faster... For most of spec2000 modulo two or three cache-bound
>    tests that are 50% slower :-(.
> 
> How about some test where relocations come into play?
> spec2000 is a bad example, it's just crunch code.

time ./configure might be a good test...

> Most systems spend their time running quick small executables over and
> over, and in such cases relocation overhead shows up very strongly.

Really? What workload besides configure does many small programs?

> This is why I asked for fork, exec et al. latency figures for 32-bit
> vs 64-bit on x86_64 but I've been informed in private email that
> nobody can send me numbers due to NDAs.
> 
> I still think making the simple programs like ls, cat, bash et
> al. 64-bit in a dist is a bad idea.

Agreed for ls and cat, but I do not think it hurts for bash...

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
