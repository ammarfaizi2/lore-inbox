Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270693AbRHKAAX>; Fri, 10 Aug 2001 20:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270694AbRHKAAN>; Fri, 10 Aug 2001 20:00:13 -0400
Received: from zero.aec.at ([195.3.98.22]:24075 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S270693AbRHKAAE>;
	Fri, 10 Aug 2001 20:00:04 -0400
To: lk@tantalophile.demon.co.uk (Jamie Lokier)
cc: linux-kernel@vger.kernel.org
Subject: Re: Half Duplex and Zero Copy IP
In-Reply-To: <20010810095313.A6219@home.com> <k266bveos8.fsf@zero.aec.at> <20010811005037.A5591@thefinal.cern.ch>
From: Andi Kleen <ak@muc.de>
Date: 11 Aug 2001 02:00:14 +0200
In-Reply-To: lk@tantalophile.demon.co.uk's message of "Fri, 10 Aug 2001 23:52:38 +0000 (UTC)"
Message-ID: <k2vgjvcvox.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010811005037.A5591@thefinal.cern.ch>,
lk@tantalophile.demon.co.uk (Jamie Lokier) writes:
> This means that you cannot use mmap() on a packet socket to zero-copy
> read whole packets.  In fact there is no way to zero-copy read whole
> packets into user space, without modifying the kernel.

[...]
Yes, sorry, I should have written single copy.
Zero copy read is currently only possible for kernel clients with hacks.

-Andi

