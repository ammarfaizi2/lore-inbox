Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286303AbSASRjF>; Sat, 19 Jan 2002 12:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286336AbSASRiz>; Sat, 19 Jan 2002 12:38:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:25674 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S286303AbSASRig>; Sat, 19 Jan 2002 12:38:36 -0500
Date: Sat, 19 Jan 2002 18:38:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Rohland <cr@sap.com>, Wilhelm Nuesser <wilhelm.nuesser@sap.com>,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: Re: clarification about redhat and vm
Message-ID: <20020119183845.E21279@athlon.random>
In-Reply-To: <m3wuye397w.fsf@linux.local> <E16Rvwa-0001ES-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E16Rvwa-0001ES-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Jan 19, 2002 at 01:54:04PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2002 at 01:54:04PM +0000, Alan Cox wrote:
> > BTW since we are just bashing VMs: I always hear that 2.2 is so much
> > better: The first 2.2 kernel which could really survive this test was
> > 2.2.19!
> 
> That I can believe. With the exception of the dcache balancing problem the
> 2.2.19/20 VM basically eliminated all 2.2 bug reports on VM behaviour.

can you reproduce the dcache problem with this patch applied?

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.20aa1/00_inode-boot-dynamic-3

The grow of the dcache in 2.2 is bound to the grow of the icache which
is not dynamic in 2.2. (modulo hardlinks but I don't think the guy was
using hardlinks)

Andrea
