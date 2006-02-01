Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161041AbWBAQlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbWBAQlS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbWBAQlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:41:18 -0500
Received: from pat.uio.no ([129.240.130.16]:24051 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161041AbWBAQlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:41:17 -0500
Subject: Re: [BUG] nfs version 2 broken
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       nfs@lists.sourceforge.net
In-Reply-To: <43E05FA1.6070407@t-online.de>
References: <43E05031.2000107@t-online.de>
	 <1138774519.7861.4.camel@lade.trondhjem.org>  <43E0567F.20004@t-online.de>
	 <1138775744.7875.0.camel@lade.trondhjem.org> <43E05FA1.6070407@t-online.de>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 11:41:05 -0500
Message-Id: <1138812065.7858.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.868, required 12,
	autolearn=disabled, AWL 1.13, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 08:13 +0100, Knut Petersen wrote:
> >>AOpen i915GMm-HFS with Pentium M, linux kernel 2.6.15-git7
> >>running a system that startet as SuSE 9.2. Nfs-utils are still
> >>the original 1.0.6, grep -i nfs linuxbuild/.config gives
> >>    
> >>
> >
> >...and what kind of filesystem are you exporting?
> >
> >  
> >
> 
> I think it is _not_ related to reiserfs. Moving my
> exported /tftpboot directory to a fresh ext2 partition
> gave the same results - failing with nfs 2, succeeding with
> nfs 3.

Does it do the same if you mount the same partition normally (i.e. not
through nfsroot) in some other directory?

Cheers,
  Trond

