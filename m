Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbUJ1BRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbUJ1BRK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 21:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbUJ1BRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 21:17:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:56293 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262609AbUJ1BQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 21:16:17 -0400
Date: Wed, 27 Oct 2004 18:16:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Randolph Chung <randolph@tausq.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch/Makefile] Fix cc-option call for xcompiles
In-Reply-To: <20041027231814.GF12356@tausq.org>
Message-ID: <Pine.LNX.4.58.0410271813310.28839@ppc970.osdl.org>
References: <20041027231814.GF12356@tausq.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Oct 2004, Randolph Chung wrote:
>
> Signed-off-by: Randolph Chung <tausq@debian.org>
> 
> Index: Makefile
> ===================================================================
> RCS file: /var/cvs/linux-2.6/Makefile,v
> retrieving revision 1.281
> diff -u -p -r1.281 Makefile
> --- Makefile	27 Oct 2004 21:23:19 -0000	1.281

Can you please make your patches be -p1 based? With CVS, I think just 
using "cvs diff -u ." should do it.

Otherwise I'll have to edit the patch to make it work with the tools (not 
a big deal for a single file diff, but..)

		Linus
