Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263824AbUEXB6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUEXB6x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 21:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUEXB6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 21:58:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:22992 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263824AbUEXB6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 21:58:50 -0400
Date: Sun, 23 May 2004 18:56:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc1
In-Reply-To: <40B1180F.8000501@pobox.com>
Message-ID: <Pine.LNX.4.58.0405231856040.25502@ppc970.osdl.org>
References: <200405231619.i4NGJBe18903@pincoya.inf.utfsm.cl> <40B0EE6C.70400@pobox.com>
 <20040523211154.GC1833@holomorphy.com> <40B1180F.8000501@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 May 2004, Jeff Garzik wrote:
>
> William Lee Irwin III wrote:
> > I wouldn't qualify either of the major VM patch series merged as
> > rewrites. I saw:
> > (1) move unmapping function/helpers to different algorithm to save space
> > (2) NUMA API and support functions
> 
> You missed the pte chains going away, a fundamental change in the way 
> reverse mapping is done?

It's not "fundamental", in that the reverse mapping is still done. It's 
just done in a slightly different way.

Going to rmap was a _fundamental_ change to how we did VM. In contrast, 
this was just an "implementation detail".

		Linus
