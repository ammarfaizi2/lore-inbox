Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267462AbUHRSaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267462AbUHRSaN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 14:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUHRSaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 14:30:13 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:32404 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267418AbUHRS2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 14:28:55 -0400
Date: Wed, 18 Aug 2004 11:28:43 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] 2.6.8-rc4-mm1 - Fix UML build
Message-ID: <20040818182843.GA7749@taniwha.stupidest.org>
References: <200408120414.i7C4EtJd010481@ccure.user-mode-linux.org> <20040815150635.5ac4f5df.akpm@osdl.org> <200408170602.i7H62LNj019126@ccure.user-mode-linux.org> <20040816220816.1b30fd53.akpm@osdl.org> <200408171915.i7HJF5KF003348@ccure.user-mode-linux.org> <20040817112629.04c7f672.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817112629.04c7f672.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 11:26:29AM -0700, Andrew Morton wrote:

> Frankly, when a subsystem gets this far out of date I don't think it
> matters a lot - nobody has much hope of following all the changes
> anyway.  We'll just merge the megapatch on the assumption that Jeff
> knows what he's doing, and that it's better than what we had before.
> You should have seen the size of some of those MIPS patches ;)

I've been pushing for a large giant UML merge for ages, mostly as
nobody is looking over the broken down patches much anyhow...

I'd even be happy with the current stuff being shoved into mainline
even if it doesn't build for a few days until it gets fixed --- not
having a common point of reference is really quite frustrating.

There are a ton of white-space cleanups and sparsification changes
that could be done too --- I assume this would be best done *before* a
giant-patch merge?


  --cw
