Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271814AbRHUSku>; Tue, 21 Aug 2001 14:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271811AbRHUSjZ>; Tue, 21 Aug 2001 14:39:25 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:29124 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S271807AbRHUSix>; Tue, 21 Aug 2001 14:38:53 -0400
Date: Tue, 21 Aug 2001 19:40:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Christoph Rohland <cr@sap.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Erik Andersen <andersee@debian.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] sysinfo compatibility
In-Reply-To: <m34rr12ueb.fsf@linux.local>
Message-ID: <Pine.LNX.4.21.0108211929540.2626-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Aug 2001, Christoph Rohland wrote:
> 
> I think it's not the kernels task to fix simple user space errors by
> breaking compatibility.

This code, either way, is all about trying to keep compatibility with
2.2.  You know some instances which are broken by the current code,
Alan knows some instances which would be broken by your code.

> And I have somewhat harder feelings since we get a lot of bug reports
> that our installer only detects 0M RAM when running on a 2.4 machine
> while it works with the 2.2 kernel. We are talking about an ABI which
> is directly imported into user space programs.

So fix your installer to work with either, isn't that what really
needs to be done?  However you play with 2.4's sysinfo, your current
2.2 installer will give wrong results on some RAM sizes, won't it?

> Uh, oh. Try this one instead:

I think this one is correct (and much clearer than what's currently
there).  But whether it should be applied is for Alan to decide...

Hugh

