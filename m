Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbTEWP1N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 11:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264086AbTEWP1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 11:27:13 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:47537 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S264085AbTEWP1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 11:27:12 -0400
Date: Fri, 23 May 2003 16:42:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Lothar Wassmann <LW@KARO-electronics.de>
cc: Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at
 least))
In-Reply-To: <16078.6171.194338.398568@ipc1.karo>
Message-ID: <Pine.LNX.4.44.0305231640150.1570-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003, Lothar Wassmann wrote:
> I'm using a custom PXA250/255 board (same problem on both processors)
> with either kernel 2.5.30-rmk1-pxa1 or 2.5.68-rmk1-pxa1. Both show the
> same malfunction when reading a file non-sequentially from an IDE CF
> card.

Which filesystem - jffs2 or some other?

Hugh

