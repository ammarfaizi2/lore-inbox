Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129550AbQKKOa5>; Sat, 11 Nov 2000 09:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129822AbQKKOar>; Sat, 11 Nov 2000 09:30:47 -0500
Received: from Cantor.suse.de ([194.112.123.193]:520 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129550AbQKKOaj>;
	Sat, 11 Nov 2000 09:30:39 -0500
Date: Sat, 11 Nov 2000 15:30:36 +0100
From: Andi Kleen <ak@suse.de>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Robert Lynch <rmlynch@best.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001111153036.A28928@gruyere.muc.suse.de>
In-Reply-To: <3A0C86B3.62DA04A2@best.com> <20001110234750.B28057@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001110234750.B28057@wire.cadcamlab.org>; from peter@cadcamlab.org on Fri, Nov 10, 2000 at 11:47:50PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 11:47:50PM -0600, Peter Samuelson wrote:
> 2b) If yes, write a perl script to compute symbol sizes from each
>     System.map file.  (Symbol size == address of next symbol minus
>     address of this symbol.)  Sort numerically, then compare old vs new
>     for symbols that have grown a lot, or large new symbols.

No need to write one: ftp.firstfloor.org:/pub/ak/perl/bloat-o-meter



-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
