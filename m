Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267398AbUHJCHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267398AbUHJCHg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 22:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267399AbUHJCHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 22:07:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:55184 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267398AbUHJCHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 22:07:30 -0400
Date: Mon, 9 Aug 2004 19:07:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Gibson <david@gibson.dropbear.id.au>
cc: Anton Blanchard <anton@samba.org>, akpm@osdl.org, dwg@dropbear.id.au,
       paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [ppc64] Fix SLB castout issue
In-Reply-To: <20040810014909.GB19776@zax>
Message-ID: <Pine.LNX.4.58.0408091906480.1839@ppc970.osdl.org>
References: <20040809204415.GG24690@krispykreme> <20040810014909.GB19776@zax>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Aug 2004, David Gibson wrote:
> 
> Anton, can you get the SFS guys to check with the patch below.  It
> reverts your patch, but then replaces the old check against r1 with a
> check against PACAKSAVE - assuming I haven't missed some corner case,
> I think this is a better fix.

Can you guys re-send this after confirmation, I'll drop it for now..

		Linus
