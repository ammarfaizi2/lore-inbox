Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbQKQOFC>; Fri, 17 Nov 2000 09:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129111AbQKQOEv>; Fri, 17 Nov 2000 09:04:51 -0500
Received: from Cantor.suse.de ([194.112.123.193]:31756 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129094AbQKQOEr>;
	Fri, 17 Nov 2000 09:04:47 -0500
Date: Fri, 17 Nov 2000 14:31:50 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Rohland <cr@sap.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Tigran Aivazian <tigran@veritas.com>,
        Mikael Pettersson <mikpe@csd.uu.se>, Jordan <ledzep37@home.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error in x86 CPU capabilities starting with test5/6
Message-ID: <20001117143150.A6832@gruyere.muc.suse.de>
In-Reply-To: <E13wkLK-0000bP-00@the-village.bc.nu> <qwwpujuvk1s.fsf@sap.com> <3A152DC1.21B35324@mandrakesoft.com> <qwwlmuivio0.fsf@sap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <qwwlmuivio0.fsf@sap.com>; from cr@sap.com on Fri, Nov 17, 2000 at 02:21:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 02:21:03PM +0100, Christoph Rohland wrote:
> Hi Jeff,
> 
> On Fri, 17 Nov 2000, Jeff Garzik wrote:
> > IIRC, this came up a long time ago WRT Apache, which made a lot of
> > gettimeofday() calls.  Someone (Linus?) proposed the solution of a
> > 'magic page' which holds information like gettimeofday() stuff, but
> > could be handled much more rapidly than a standard syscall.
> 
> Yes, I followed that thread closely and would love to see this as the
> implementation for gettimeofday. This would make rdtsc for
> applications superfluous.

No it would not. Often you want cycle accurate couting for profiling
purposes.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
