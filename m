Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265191AbUAYTOS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbUAYTOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:14:18 -0500
Received: from colin2.muc.de ([193.149.48.15]:20490 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265191AbUAYTOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:14:16 -0500
Date: 25 Jan 2004 20:12:32 +0100
Date: Sun, 25 Jan 2004 20:12:32 +0100
From: Andi Kleen <ak@muc.de>
To: Valdis.Kletnieks@vt.edu
Cc: Andi Kleen <ak@muc.de>, Adrian Bunk <bunk@fs.tum.de>,
       Fabio Coatti <cova@ferrara.linux.it>, Andrew Morton <akpm@osdl.org>,
       Eric <eric@cisu.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040125191232.GC16962@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net> <200401251639.56799.cova@ferrara.linux.it> <20040125162122.GJ513@fs.tum.de> <200401251811.27890.cova@ferrara.linux.it> <20040125173048.GL513@fs.tum.de> <20040125174837.GB16962@colin2.muc.de> <200401251800.i0PI0SmV001246@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401251800.i0PI0SmV001246@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 01:00:27PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 25 Jan 2004 18:48:37 +0100, Andi Kleen said:
> 
> > It works for me with the hammer branch gcc 3.3 with -funit-at-a-time.
> 
> > Are you sure the exception table sorting patch was properly applied?
> 
> Was that patch an x86 issue as well, or only on the 64-bit boxes?  And if it
> is a x86 issue, can you repost what *you* think it is (as opposed to what the -mm
> patch thinks it is?)

The latest bk tree (post 2.6.2rc1) has a full solution that should cover
all architectures.

AFAIK there is a known problem on MIPS (not related to the exception tables)

If someone is seeing crashes with a BK snapshot from today and -funit-at-a-time
please send me the decoded oops.

-Andi

