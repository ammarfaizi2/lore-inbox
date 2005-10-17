Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbVJQPlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbVJQPlM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVJQPlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:41:11 -0400
Received: from rs1.theo-phys.uni-essen.de ([132.252.73.3]:36226 "EHLO
	rs1.Theo-Phys.Uni-Essen.DE") by vger.kernel.org with ESMTP
	id S1751401AbVJQPlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:41:09 -0400
Message-Id: <200510171540.RAA12458@next12.theo-phys.uni-essen.de>
Content-Type: text/plain
MIME-Version: 1.0 (NeXT Mail 4.2mach_patches v148.2)
In-Reply-To: <4353B297.5080604@moving-picture.com>
X-Nextstep-Mailer: Mail 4.2mach_patches [i386] (Enhance 2.2p3, May 2000)
From: Ruediger Oberhage <ruediger@next12.theo-phys.uni-essen.de>
Date: Mon, 17 Oct 2005 17:40:15 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: NFS client problem with kernel 2.6 and SGI IRIX 6.5
cc: ruediger@Theo-Phys.Uni-Essen.DE,
       James Pearson <james-p@moving-picture.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Reply-To: ruediger@Theo-Phys.Uni-Essen.DE
References: <4353B297.5080604@moving-picture.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this similar to the issue in the following thread? :

> http://marc.theaimsgroup.com/?l=linux-kernel&m=108741268200839&w=2

I still have to investigate Trond Myklebust's suggestions (strace on
'df' with unmodified 2.6 kernel and 2.6.12 and the tcpdump on
the malfunctioning nfs, hopefully can do it tomorrow, but from
memory, I think the following holds:

When 'your' thread above, which leads to the URL
http://www.fys.uio.no/~trondmy/src/2.4.18/linux-2.4.18-seekdir.dif,
that isn't available any longer (at least here), is similar to

http://www.ussg.iu.edu/hypermail/linux/kernel/0502.1/0506.html
http://kerneltrap.org/mailarchive/1/message/19372/thread

that is the patch, that I applied to some kernels earlier than
2.6.11, then the behaviour is, that with this patch or a 'recent'
kernel (I do believe it starts with 2.6.11), the 'find'-problem
goes away - I'll re-check that -, but the 'other' problems
(Mathematica and OpenOffice not finding certain 'resources')
stay.

Nevertheless, 'seekdir' sounds very promising as a cause for
the problem(s), so if 'linux-2.4.18-seekdir.dif' is handling a
problem different from '0506.html', then it may be worth
investigating.

Since I can't access linux-2.4.18-seekdir.dif, could you please
either have a look if it's the same thing else send me that patch?

Thank you very much,
 Ruediger Oberhage
