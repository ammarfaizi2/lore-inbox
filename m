Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265656AbUA0Xaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265658AbUA0Xaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:30:52 -0500
Received: from colin2.muc.de ([193.149.48.15]:51719 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265656AbUA0Xau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:30:50 -0500
Date: 28 Jan 2004 00:29:50 +0100
Date: Wed, 28 Jan 2004 00:29:50 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, eric@cisu.net, stoffel@lucent.com,
       Valdis.Kletnieks@vt.edu, bunk@fs.tum.de, cova@ferrara.linux.it,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040127232950.GA63863@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net> <200401261326.09903.eric@cisu.net> <20040126115614.351393f2.akpm@osdl.org> <200401262343.35633.eric@cisu.net> <20040126215056.4e891086.akpm@osdl.org> <20040127162043.GA98702@colin2.muc.de> <20040127125447.31631e14.akpm@osdl.org> <20040127223009.GA81095@colin2.muc.de> <20040127151644.1fb378c2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040127151644.1fb378c2.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll turn it on for gcc-3.3 and higher.  We can change that if someone has
> tested earlier compilers.

Earlier compilers never supported -funit-at-a-time. The option 
was first implemented in gcc 3.3-hammer and later merged into 3.4.

> Also, I do think this should remain a per-arch decision.  Other
> architectures could well have similar problems to this and we don't want to
> be mysteriously breaking their kernels for them.

That's fine by me. While you're at it could you enable it for x86-64 too?

-Andi
