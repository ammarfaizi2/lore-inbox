Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUDTSQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUDTSQQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 14:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263724AbUDTSQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 14:16:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:660 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263448AbUDTSQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 14:16:15 -0400
Date: Tue, 20 Apr 2004 18:15:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: chris@scary.beasts.org, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add 64-bit get_user and __get_user for i386
In-Reply-To: <20040420174147.GA20924@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0404201808150.2653@ppc970.osdl.org>
References: <20040420020922.GA18348@mail.shareable.org>
 <Pine.LNX.4.58.0404191945490.29941@ppc970.osdl.org> <20040420174147.GA20924@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Apr 2004, Jamie Lokier wrote:
>
> Patch re-rolled.  The only change is the removal of that cast,
> and a clarifying comment in getuser.S.

Well, it's not applying against current kernels (which have already 
un-inlined some of these things), and that comment still isn't clear to 
me. There's a comment about casting things, but the thing is, the macro 
contains no casts anywhere...

Other than that, I'm convinced.

		Linus
