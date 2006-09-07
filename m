Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbWIGArr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbWIGArr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 20:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbWIGArr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 20:47:47 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:41661 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161036AbWIGArq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 20:47:46 -0400
Date: Thu, 7 Sep 2006 02:47:42 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] re-add -ffreestanding
In-Reply-To: <20060907003758.GD25473@stusta.de>
Message-ID: <Pine.LNX.4.64.0609070245100.6761@scrub.home>
References: <20060830175727.GI18276@stusta.de> <200608302013.58122.ak@suse.de>
 <20060830183905.GB31594@flint.arm.linux.org.uk> <20060906223748.GC12157@stusta.de>
 <Pine.LNX.4.64.0609070115270.6761@scrub.home> <20060906235029.GC25473@stusta.de>
 <Pine.LNX.4.64.0609070202040.6761@scrub.home> <20060907003758.GD25473@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Sep 2006, Adrian Bunk wrote:

> > BS, even without it gcc can't make such assumption.
> > There is not a single optimization, which would be invalid in a kernel 
> > environment and would be "fixed" by this option, so please stop this 
> > nonsense.
> 
> You are wrong.
> 
> Section 5.1.2.2.2 of ISO/IEC 9899:1999 says:
> In a hosted environment, a program may use all functions, macros, type 
> definitions, and objects described in the library clause (clause 7).
> 
> Since a hosted environment means gcc+libc, it's therefore clear that gcc 
> can assume the presence of a full libc if gcc isn't told that it's used 
> as a freestanding environment.

Define "full libc".
Explain what exactly -ffreestanding fixes, which is not valid for the 
kernel.

byem Roman
