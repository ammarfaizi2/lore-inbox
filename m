Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbUAYWcz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 17:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbUAYWcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 17:32:54 -0500
Received: from colin2.muc.de ([193.149.48.15]:6414 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262033AbUAYWcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 17:32:53 -0500
Date: 25 Jan 2004 23:31:05 +0100
Date: Sun, 25 Jan 2004 23:31:05 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, cova@ferrara.linux.it, bunk@fs.tum.de,
       eric@cisu.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040125223105.GE28576@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net> <200401252221.01679.cova@ferrara.linux.it> <20040125214653.GB28576@colin2.muc.de> <200401252308.33005.cova@ferrara.linux.it> <20040125221304.GD28576@colin2.muc.de> <20040125142500.526dcac5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125142500.526dcac5.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 02:25:00PM -0800, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> > I would suspect the new weird CPU
> >  configuration stuff.
> 
> What do you believe is wrong with it?

It's different and it is weird and probably easy to screw up.

It's just that CPU configuration errors often cause problems before
the console is running.  And we unfortunately still don't have 
early printk on i386, which makes it hard to diagnose.

-Andi
