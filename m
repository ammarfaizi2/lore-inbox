Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132147AbQLQJiF>; Sun, 17 Dec 2000 04:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132255AbQLQJhy>; Sun, 17 Dec 2000 04:37:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47111 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132147AbQLQJho>;
	Sun, 17 Dec 2000 04:37:44 -0500
Date: Sun, 17 Dec 2000 09:07:09 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: Drew Hess <dhess@CS.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i850 support
Message-ID: <20001217090709.D21944@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.GSO.4.21.0012170028520.6727-100000@Xenon.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0012170028520.6727-100000@Xenon.Stanford.EDU>; from dhess@CS.Stanford.EDU on Sun, Dec 17, 2000 at 12:52:59AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 17, 2000 at 12:52:59AM -0800, Drew Hess wrote:
> It also contains an experimental patch to drivers/pci/quirks.c that forces
> standby mode for pool C RDRAM devices.  I've seen some benchmarks
> comparing the Intel D850GB motherboard to the ASUS P4T and attributing the
> better performance of the P4T to the fact that Intel's BIOS puts pool C
> RDRAM in nap mode and has no option to change it, whereas the P4T does.  
> On my D850GB, the patch doesn't seem to change the performance of STREAM
> one way or the other; but when I change the value written into the RDST
> register to set nap mode and shrink the A and B pools to 1 device each, I
> see about a 20-30MB/s drop-off on STREAM, so I'm pretty sure the code does
> what it's supposed to.
> 
> This code isn't strictly a 'quirk' in the sense that some of the bug
> workarounds in drivers/pci/quirks.c are, but I didn't see a more
> appropriate place to put it.  Suggestions are welcome.

sounds like powertweak is what you want.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
