Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289113AbSAQPLH>; Thu, 17 Jan 2002 10:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289136AbSAQPKr>; Thu, 17 Jan 2002 10:10:47 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:5156 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289113AbSAQPKf>; Thu, 17 Jan 2002 10:10:35 -0500
Date: Thu, 17 Jan 2002 16:10:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: clarification about redhat and vm
Message-ID: <20020117161055.K4847@athlon.random>
In-Reply-To: <20020116200459.E835@athlon.random> <E16RCYR-0003GW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E16RCYR-0003GW-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 17, 2002 at 01:26:07PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 01:26:07PM +0000, Alan Cox wrote:
> > If redhat doesn't use the -aa VM into their kernels that's either a
> > political decision or they're not good enough at the VM. I can tell you
> 
> If you want to insult the Red Hat people please don't do it from a SuSE
> address. There are some great people at SuSE and I somehow doubt you speak
> for the management or major stockholders (ibm etc)

do you plan to sue me as well? :)

"If redhat doesn't use the -aa VM " was a short form of "if redhat
cannot see the goodness of all the bugfixing work that happened between
the 2.4.9 VM and any current branch 2.4, and so if they keep shipping
2.4.9 VM as the best one for DBMS and critical VM apps like the SAP
benchmark".

I think it's fair enough to say that if you plan to keep shipping 2.4.9
VM with all its troubles like I understood yesterday (starting from VM
highmem deadlocks, to kswapd looping into ZONE_DMA etc..., swap storms
throwing the realistic SAP benchmark to /dev/null) that was not usable
on long uptimes on big DBMS with several gigabytes of ram.

Somebody else also complained me about this saying that from what I said
it looks like the -aa VM is the best thing possible which is obviously
not true. In such two lines I said -aa VM just to go short. The -aa VM
in 2.4.18pre2aa2 is obviously certainly not the best that you can make
and I suggest everybody to try to make things better and invent and try
new algorithm etc...  that is just the best compromise that _I_ could
make so far. So it is obvious if anybody doesn't use the -aa VM in
2.4.18pre2aa2 it doesn't mean he doesn't understand about VM.  as far I
can tell rmap could be an order of magnitude better of -aa VM in
2.4.18pre2aa2, it's just I didn't checked it yet (because of all the non
obvious implication the rmap design adds, see DaveM emails of one year
back to linux-mm). All my wondering in my previous email was between
2.4.9 VM with all its known troubles and a sane version of the current
vm like in 2.4.18pre2aa2. So about the past and the present, not about
the present and the future. I thought it was obvious from the context of
the email. I said this in two lines and apparently RedHat didn't like
it, I'm sorry, but quite frankly I think that was quite fair enough, at
least with this additional clarification added.

Andrea
