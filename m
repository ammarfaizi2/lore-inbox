Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbVJ1Ofy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbVJ1Ofy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbVJ1Ofy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:35:54 -0400
Received: from rs1.theo-phys.uni-essen.de ([132.252.73.3]:33255 "EHLO
	rs1.Theo-Phys.Uni-Essen.DE") by vger.kernel.org with ESMTP
	id S1030195AbVJ1Ofy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:35:54 -0400
Message-Id: <200510281435.QAA18054@next12.theo-phys.uni-essen.de>
Content-Type: text/plain
MIME-Version: 1.0 (NeXT Mail 4.2mach_patches v148.2)
In-Reply-To: <20051026034235.GB6423@verge.net.au>
X-Nextstep-Mailer: Mail 4.2mach_patches [i386] (Enhance 2.2p3, May 2000)
From: Ruediger Oberhage <ruediger@next12.theo-phys.uni-essen.de>
Date: Fri, 28 Oct 2005 16:35:36 +0200
To: 325117@bugs.debian.org
Subject: Re: Bug#325117: NFS client problem with kernel 2.6 and SGI IRIX 6.5
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Horms <horms@debian.org>,
       ruediger@theo-phys.uni-essen.de, linux-kernel@vger.kernel.org
Reply-To: ruediger@theo-phys.uni-essen.de
References: <200510140905.LAA10947@next12.theo-phys.uni-essen.de>
	<1129314142.8443.13.camel@lade.trondhjem.org>
	<200510191652.SAA13594@next12.theo-phys.uni-essen.de>
	<1129756421.8971.19.camel@lade.trondhjem.org>
	<20051026034235.GB6423@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all!

I would like to report/confirm success in solving the problem
described after applying the patch below:

> >  
http://client.linux-nfs.org/Linux-2.6.x/2.6.12/linux-2.6.12-43-dirent_fix.dif
> >
> > This should normally suffice to fix the SGI problem.

Yes, it effectively eliminates both type of problems for our/my
configuration here - the 'find'-error as well as the 'resources'-
error (= OpenOffice 'printer' and Mathematica 'fonts, files,
directories etc.). Thus this patch is more effective that the
one in KNOPPIX' 4.0 kernel!

Thought, you'd like to know.

My sincere thanks to all helping out in this, here.

As I normally don't read the lists involved, I won't see other
problems with nfs and the SGI configuration. Should you feel
that testing here could be of any help, then please don't
hesitate to ask me about it - I'd like to return the favour
granted, if I can.

> Thanks, I'll confine subseqent discussion to 325117@bugs.debian.org
> as debian packaging issues don't need to be on lkml.

This is fine with me - I just wanted to let everyone involved know
about the outcome. [This is most probably my last report regarding
this 'bug'. Thus you're all going to miss this 'fine tcpdump'-list
I promised; that is, unless somebody asks for it :-).]

Thanks again,
 Ruediger Oberhage
--
H.-R. Oberhage
Mail: Univ. Duisburg-Essen	E-Mail:	oberhage@Uni-Essen.DE
      Fachbereich Physik		ruediger@Theo-Phys.Uni-Essen.DE
      Campus Essen, S05 V07 E88
      Universitaetsstrasse 5	Phone:  {+49|0} 201 / 183-2493
      45141 Essen, Germany	FAX:    {+49|0} 201 / 183-4578
