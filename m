Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVEQVlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVEQVlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 17:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVEQVlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 17:41:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:9645 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261326AbVEQVkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:40:45 -0400
Date: Tue, 17 May 2005 14:42:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: git@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: Re: [PATCH] uml: remove elf.h
In-Reply-To: <20050517142113.59097a3d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0505171440470.18337@ppc970.osdl.org>
References: <200505171704.j4HH4Ne8002532@hera.kernel.org>
 <20050517142113.59097a3d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 May 2005, Andrew Morton wrote:
> 
> And I bet that when Linus releases patch-2.6.12-rc5.gz and patch-2.6.12.gz,
> they will have the same construct.  AFAICT, the patch-based people will
> need to download a full new tarball to get rid of this dang file.

Or just run "make distclean" once.

> It all wouldn't really matter much, except apparently the mere presence of
> this file breaks the UML build.
> 
> Frazzle.  Paolo, I'm almost wondering if we should change that test to also
> check for a zero-length file.

How many people are affected? The file _is_ gone in the git archives, and 
in fact I wonder if it was ever there, but I didn't bother to check.

		Linus
