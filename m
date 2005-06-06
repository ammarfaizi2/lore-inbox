Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVFFVvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVFFVvh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVFFVvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:51:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:41357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261707AbVFFVvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:51:23 -0400
Date: Mon, 6 Jun 2005 14:53:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@suse.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
In-Reply-To: <20050606214124.GL2230@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0506061452320.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
 <20050606192654.GA3155@elf.ucw.cz> <Pine.LNX.4.58.0506061310500.1876@ppc970.osdl.org>
 <20050606201441.GG2230@elf.ucw.cz> <Pine.LNX.4.58.0506061411410.1876@ppc970.osdl.org>
 <20050606211849.GK2230@elf.ucw.cz> <Pine.LNX.4.58.0506061433480.1876@ppc970.osdl.org>
 <20050606214124.GL2230@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Jun 2005, Pavel Machek wrote:
> 
> Okay, I see. I'm little afraid that during forwards blank line will be
> inserted before "From: " and break this, but lets see how it works.

Oh, I skip blank lines (and that means any line that is "whitespace only", 
ie tabs/spaces etc won't confuse the scripts), so at least it's not _that_ 
subtle.

		Linus
