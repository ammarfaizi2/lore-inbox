Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTJDI3I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 04:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbTJDI3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 04:29:08 -0400
Received: from colin2.muc.de ([193.149.48.15]:34309 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261950AbTJDI3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 04:29:04 -0400
Date: 4 Oct 2003 10:29:17 +0200
Date: Sat, 4 Oct 2003 10:29:17 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, joe.korty@ccur.com, linux-kernel@vger.kernel.org
Subject: Re: mlockall and mmap of IO devices don't mix
Message-ID: <20031004082917.GA23306@colin2.muc.de>
References: <CFYv.787.23@gated-at.bofh.it> <m34qyp7ae4.fsf@averell.firstfloor.org> <20031004004246.13d1f977.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031004004246.13d1f977.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is not a trivial thing to do now we no longer have a single mem_map[].

2.4/DISCONTIGMEM also didn't have a single mem_map and it worked there
fine.

I implemented it for x86-64. Arguably it was a bit ugly, but not too bad.

-Andi
