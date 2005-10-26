Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVJZEeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVJZEeR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 00:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVJZEeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 00:34:17 -0400
Received: from koto.vergenet.net ([210.128.90.7]:28322 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S932120AbVJZEeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 00:34:16 -0400
Date: Wed, 26 Oct 2005 12:42:38 +0900
From: Horms <horms@debian.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>, 325117@bugs.debian.org
Cc: ruediger@theo-phys.uni-essen.de, linux-kernel@vger.kernel.org
Subject: Re: Bug#325117: NFS client problem with kernel 2.6 and SGI IRIX 6.5
Message-ID: <20051026034235.GB6423@verge.net.au>
References: <200510140905.LAA10947@next12.theo-phys.uni-essen.de> <1129314142.8443.13.camel@lade.trondhjem.org> <200510191652.SAA13594@next12.theo-phys.uni-essen.de> <1129756421.8971.19.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129756421.8971.19.camel@lade.trondhjem.org>
X-Cluestick: seven
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2005 at 02:13:41PM -0700, Trond Myklebust wrote:
> on den 19.10.2005 klokka 18:52 (+0200) skreiv Ruediger Oberhage:
> > Hello again.
> > 
> > Some first findings regarding nfs problems:
> > 
> > At first I have to apologize for my memory (again :-)) serving me
> > wrong: I did state, that the "find /nfsDir -print" problem was
> > (generally) gone with the 2.6.12 kernel; this is wrong(!).
> > 
> > The problem does exist for both (Debianized) kernels 2.6.8 as well
> > as 2.6.12 (the details follow below in the 'strace'-dump). The
> > (find-)problem does NOT exist for the (2.6.12-)kernel delivered on
> > the KNOPPIX 4.0 DVD!!! So there is a cure for some kernel for this
> > one. The 'resources'-problem (OpenOffice/Mathematica) still remains
> > for this kernel, too!
> 
> Recent kernels (2.6.13 and above - sorry, I though it was 2.6.12) have
> the following patch applied
> 
> http://client.linux-nfs.org/Linux-2.6.x/2.6.12/linux-2.6.12-43-dirent_fix.dif
> 
> This should normally suffice to fix the SGI problem.

Thanks, I'll confine subseqent discussion to 325117@bugs.debian.org
as debian packaging issues don't need to be on lkml.

-- 
Horms
