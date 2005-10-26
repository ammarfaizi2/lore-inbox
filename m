Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbVJZIFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbVJZIFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 04:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbVJZIFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 04:05:04 -0400
Received: from rs1.theo-phys.uni-essen.de ([132.252.73.3]:37007 "EHLO
	rs1.Theo-Phys.Uni-Essen.DE") by vger.kernel.org with ESMTP
	id S932583AbVJZIFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 04:05:02 -0400
Message-Id: <200510260804.KAA16550@next12.theo-phys.uni-essen.de>
Content-Type: text/plain
MIME-Version: 1.0 (NeXT Mail 4.2mach_patches v148.2)
In-Reply-To: <20051026034235.GB6423@verge.net.au>
X-Nextstep-Mailer: Mail 4.2mach_patches [i386] (Enhance 2.2p3, May 2000)
From: Ruediger Oberhage <ruediger@next12.theo-phys.uni-essen.de>
Date: Wed, 26 Oct 2005 10:04:45 +0200
To: Horms <horms@debian.org>
Subject: Re: Bug#325117: NFS client problem with kernel 2.6 and SGI IRIX 6.5
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, 325117@bugs.debian.org,
       ruediger@theo-phys.uni-essen.de, linux-kernel@vger.kernel.org
Reply-To: ruediger@theo-phys.uni-essen.de
References: <200510140905.LAA10947@next12.theo-phys.uni-essen.de>
	<1129314142.8443.13.camel@lade.trondhjem.org>
	<200510191652.SAA13594@next12.theo-phys.uni-essen.de>
	<1129756421.8971.19.camel@lade.trondhjem.org>
	<20051026034235.GB6423@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>  
http://client.linux-nfs.org/Linux-2.6.x/2.6.12/linux-2.6.12-43-dirent_fix.dif
> >
> > This should normally suffice to fix the SGI problem.
>
> Thanks, I'll confine subseqent discussion to 325117@bugs.debian.org
> as debian packaging issues don't need to be on lkml.

That's fine with me - for the moment at least. I'm busy applying
the patch to the "2.6.12-Debian-sarge"-kernel package. The patch
doesn't apply automatically, but I think I succeeded in doing so
manually. Now my problem is, that the kernel doesn't compile - but
not because of the patch or in the nfs-region, but with a (unused by
me) scsi-driver at the moment. I'll try to sort things out, have a
proper 'patched' kernel and shall report afterwards.

I also think, that a 'tcpdump' of the nfs-traffic makes only sense
after(!) applying the patch from a patched kernel; so I'll postpone
its submission till after I succeed (hopefully).

Be warned, though, that the KNOPPIX-kernel still has the 'resources'-
problem, although not the 'find' one. Thus if this kernel has the
'dirent_fix'-patch incorporated, it doesn't suffice. This may - later
- lead to the re-involvment of the 'nfs-kernel-group', eventually.

In the meantime, many thanks for the help - I'll try to do 'my'
homework as fast as my time allows.

Regards,
 Ruediger Oberhage
