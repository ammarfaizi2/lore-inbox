Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVJSVNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVJSVNs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 17:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVJSVNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 17:13:47 -0400
Received: from pat.uio.no ([129.240.130.16]:3800 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751157AbVJSVNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 17:13:47 -0400
Subject: Re: NFS client problem with kernel 2.6 and SGI IRIX 6.5
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: ruediger@theo-phys.uni-essen.de
Cc: linux-kernel@vger.kernel.org, 325117@bugs.debian.org
In-Reply-To: <200510191652.SAA13594@next12.theo-phys.uni-essen.de>
References: <200510140905.LAA10947@next12.theo-phys.uni-essen.de>
	 <1129314142.8443.13.camel@lade.trondhjem.org>
	 <200510191652.SAA13594@next12.theo-phys.uni-essen.de>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 14:13:41 -0700
Message-Id: <1129756421.8971.19.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.51, required 12,
	autolearn=disabled, AWL -0.02, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 19.10.2005 klokka 18:52 (+0200) skreiv Ruediger Oberhage:
> Hello again.
> 
> Some first findings regarding nfs problems:
> 
> At first I have to apologize for my memory (again :-)) serving me
> wrong: I did state, that the "find /nfsDir -print" problem was
> (generally) gone with the 2.6.12 kernel; this is wrong(!).
> 
> The problem does exist for both (Debianized) kernels 2.6.8 as well
> as 2.6.12 (the details follow below in the 'strace'-dump). The
> (find-)problem does NOT exist for the (2.6.12-)kernel delivered on
> the KNOPPIX 4.0 DVD!!! So there is a cure for some kernel for this
> one. The 'resources'-problem (OpenOffice/Mathematica) still remains
> for this kernel, too!

Recent kernels (2.6.13 and above - sorry, I though it was 2.6.12) have
the following patch applied

http://client.linux-nfs.org/Linux-2.6.x/2.6.12/linux-2.6.12-43-dirent_fix.dif

This should normally suffice to fix the SGI problem.

Cheers,
  Trond

