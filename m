Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283507AbRLDVGA>; Tue, 4 Dec 2001 16:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281555AbRLDVFq>; Tue, 4 Dec 2001 16:05:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37138 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S281202AbRLDVF0>; Tue, 4 Dec 2001 16:05:26 -0500
Date: Tue, 4 Dec 2001 21:03:38 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Christoph Rohland <cr@sap.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Maciej Zenczykowski <maze@druid.if.uj.edu.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Wrapping memory.
Message-ID: <20011204210338.C19783@flint.arm.linux.org.uk>
In-Reply-To: <m3r8qcagt7.fsf@linux.local> <E16AIZ8-0008Re-00@the-village.bc.nu> <12969.1007315617@redhat.com> <m3r8qcagt7.fsf@linux.local> <25163.1007370678@redhat.com> <20011204104047.A18147@flint.arm.linux.org.uk> <20011204163950.B28839@kushida.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011204163950.B28839@kushida.jlokier.co.uk>; from lk@tantalophile.demon.co.uk on Tue, Dec 04, 2001 at 04:39:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 04:39:50PM +0000, Jamie Lokier wrote:
> Unfortunately, the update_mmu_cache makes aliasing work properly while
> ruining performence, so then it's better to not to use the mapping trick
> at all in that case.  To check for this, I have to call gettimeofday()
> between pairs of accesses, to check whether they are slow.  I don't know
> for sure if this works because I don't have an ARM to try it on.

Why not create a program and email it to someone with an ARM machine?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

