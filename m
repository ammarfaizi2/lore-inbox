Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbTEZLcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 07:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbTEZLcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 07:32:42 -0400
Received: from [62.112.80.35] ([62.112.80.35]:28289 "EHLO ipc1.karo")
	by vger.kernel.org with ESMTP id S264346AbTEZLcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 07:32:41 -0400
Message-ID: <16081.65071.325389.208221@ipc1.karo>
Date: Mon, 26 May 2003 13:44:47 +0200
From: "Lothar Wassmann" <LW@KARO-electronics.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at
 least))
In-Reply-To: <Pine.LNX.4.44.0305231640150.1570-100000@localhost.localdomain>
References: <16078.6171.194338.398568@ipc1.karo>
	<Pine.LNX.4.44.0305231640150.1570-100000@localhost.localdomain>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins writes:
> On Fri, 23 May 2003, Lothar Wassmann wrote:
> > I'm using a custom PXA250/255 board (same problem on both processors)
> > with either kernel 2.5.30-rmk1-pxa1 or 2.5.68-rmk1-pxa1. Both show the
> > same malfunction when reading a file non-sequentially from an IDE CF
> > card.
> 
> Which filesystem - jffs2 or some other?
>
I tried VFAT, MINIX and EXT2 with the same results.


Lothar
