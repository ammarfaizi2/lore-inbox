Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313346AbSDTWBe>; Sat, 20 Apr 2002 18:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313355AbSDTWBd>; Sat, 20 Apr 2002 18:01:33 -0400
Received: from dsl-213-023-039-128.arcor-ip.net ([213.23.39.128]:26509 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313346AbSDTWBd>;
	Sat, 20 Apr 2002 18:01:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <garzik@havoc.gtf.org>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Date: Sat, 20 Apr 2002 00:01:35 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16yfW9-0000aZ-00@starship> <20020420170747.B14186@havoc.gtf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ygRk-0000bR-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 April 2002 23:07, Jeff Garzik wrote:
> On Fri, Apr 19, 2002 at 11:02:04PM +0200, Daniel Phillips wrote:
> > Martin Dalecki's IDE patch, gosh, look at all the fun.  It's a non-BK
> > patch, let's see if there's a pattern.  Hmm, the next bushy one is "[PATCH]
> > zerocopy NFS updated", descending from a traditional patch set.  The next
> > one, "[PATCH] IDE TCQ #4" is also a traditional patch.  Hmm, no bitkeeper
> > patches showing up yet, I don't think I need to go on.
> > 
> > There is a clear inverse relationship between the bk-ness of a patch and
> > the extent to which it's discussed on lkml.  I don't know what to read into
> > that, but it does seem to lend credence to the idea that the bitkeeper
> > style of working is not compatible with the idea of community discussion.
> 
> Concrete examples, please?
> 
> Which patches are the stealth patches?

Let me turn that around.  Which bitkeeper patches have been posted to lkml and
generated significant amounts of discussion on lkml in the last week?  Versus
how many lines of bitkeeper patches applied to Linus's tree?

I went through the 1,000 or so most recent postings on lkml, looking for patches
that generated discussion.  Here's what I found:

BK patches generating discussion:

[PATCH] for_each_zone / for_each_pgdat
[BK PATCH] USB device support for 2.5.8
[BKPATCH 2.4] meye driver: fix request_irq bug

Non BK patches generating discussion:

[CFT][PATCH] (1/5) sane procfs/dcache interaction
[PATCH] Documenation/vm/numa
[PATCH] fix ips driver compile problems
[PATCH] IDE TCQ #4
[PATCH] migration thread fix
[PATCH] Wrong IRQ for USB on Sony Vaio (dmi_scan.c, pci-irq.c)
[PATCH] x86 boot enhancements, boot bean counting 8/11
[PATCH][2.5-dj] P4 thermal LVT (damage control)
[PATCHSET] Linux 2.4.19-pre7-jam1
[RFC] 2.5.8 sort kernel tables
page_alloc.c comments patch
[PATCH] Re: SSE related security hole

Both BK and non-BK:

[PATCH] i386 arch subdivision into machine types for 2.5.8

The next question you might ask is: are there more BK patches or
more Non-BK, in total, on and off lkml?  I don't have statistics at
hand but I'm willing to bet that there are more BK patches, because
that is how the bulk of the grunt tree maintainance is getting
done these days.

My conclusion: though there are more BK patches being applied to Linus's
tree than non-BK, they are generating less discussion on lkml than non-BK
patches do.  Or to put it bluntly: BK patches are not being discussed.

-- 
Daniel
