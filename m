Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbQJZXGT>; Thu, 26 Oct 2000 19:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130318AbQJZXGJ>; Thu, 26 Oct 2000 19:06:09 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:11096 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129805AbQJZXFw>; Thu, 26 Oct 2000 19:05:52 -0400
Date: Fri, 27 Oct 2000 01:05:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.2.18pre17 + VM-global -7 = `Negative d_count' oops
Message-ID: <20001027010539.B1282@athlon.random>
In-Reply-To: <39F4AB91.72F2C300@transmeta.com> <20001025050631.A6817@athlon.random> <14840.27617.448792.438567@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14840.27617.448792.438567@chiark.greenend.org.uk>; from ijackson@chiark.greenend.org.uk on Thu, Oct 26, 2000 at 06:37:37PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2000 at 06:37:37PM +0100, Ian Jackson wrote:
>  Negative d_count (-805538369) for [binary garbage]/<NULL>
> 
> followed by an oops.  Kernel logfile extract below, uuencoded.

Thanks for the feedback.

The oops is forced by the kernel after it sees then wrong negative d_count.

I'd say it's memory corruption, but it doesn't look like a memory bitflip.

I'm almost certain that it's not caused by the VM-global patch.

Which device driver and compiler are you using?

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
