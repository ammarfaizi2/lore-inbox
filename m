Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265513AbUAZGL7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 01:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbUAZGL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 01:11:59 -0500
Received: from colin2.muc.de ([193.149.48.15]:31761 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265513AbUAZGLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 01:11:49 -0500
Date: 26 Jan 2004 07:09:52 +0100
Date: Mon, 26 Jan 2004 07:09:52 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: John Stoffel <stoffel@lucent.com>, ak@muc.de, Valdis.Kletnieks@vt.edu,
       bunk@fs.tum.de, cova@ferrara.linux.it, eric@cisu.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040126060952.GC6519@colin2.muc.de>
References: <20040125162122.GJ513@fs.tum.de> <200401251811.27890.cova@ferrara.linux.it> <20040125173048.GL513@fs.tum.de> <20040125174837.GB16962@colin2.muc.de> <200401251800.i0PI0SmV001246@turing-police.cc.vt.edu> <20040125191232.GC16962@colin2.muc.de> <16404.9520.764788.21497@gargle.gargle.HOWL> <20040125202557.GD16962@colin2.muc.de> <16404.10496.50601.268391@gargle.gargle.HOWL> <20040125220027.30e8cdf3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125220027.30e8cdf3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 10:00:27PM -0800, Andrew Morton wrote:
> "John Stoffel" <stoffel@lucent.com> wrote:
> >
> > Sure, the darn thing wouldn't boot, it kept Oopsing with the
> >  test_wp_bit oops (that I just posted more details about).
> 
> Does this fix the test_wp_bit oops?

He apparently doesn't have an test_wp_bit oops, but just an hang
very early (after mem_init according to early printk) 

-Andi
