Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbUEPElY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUEPElY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 00:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUEPElY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 00:41:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:28878 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262488AbUEPElX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 00:41:23 -0400
Date: Sat, 15 May 2004 21:41:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Pascal Schmidt <der.eremit@email.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NFS & long symlinks = stack overflow
In-Reply-To: <1084642637.3490.29.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.58.0405152136380.25502@ppc970.osdl.org>
References: <1W7yE-3lZ-13@gated-at.bofh.it> <1W7S5-3Am-13@gated-at.bofh.it>
  <E1BP0BI-0000lo-09@localhost>  <20040515145306.GQ17014@parcelfarce.linux.theplanet.co.uk>
 <1084642637.3490.29.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 May 2004, Trond Myklebust wrote:
> 
> Yes. The following patch (backported from the NFSv4 code) should do the
> right thing...

Why isn't this needed for nfsv2, which has similar code? 

		Linus
