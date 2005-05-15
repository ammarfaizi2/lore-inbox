Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVEOJkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVEOJkM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 05:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVEOJkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 05:40:11 -0400
Received: from mail.dif.dk ([193.138.115.101]:5093 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261585AbVEOJkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 05:40:02 -0400
Date: Sun, 15 May 2005 11:44:02 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm1
In-Reply-To: <20050514183051.38f97256.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0505151142520.2387@dragon.hyggekrogen.localhost>
References: <20050512033100.017958f6.akpm@osdl.org> <20050515012051.GJ9304@holomorphy.com>
 <20050514183051.38f97256.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 May 2005, Andrew Morton wrote:

> William Lee Irwin III <wli@holomorphy.com> wrote:
> >
> > On Thu, May 12, 2005 at 03:31:00AM -0700, Andrew Morton wrote:
> >  > +uml-remove-elfh.patch
> >  > +uml-critical-change-memcpy-to-memmove.patch
> >  >  UML important updates
> > 
> >  uml-remove-elfh looks empty.
> 
> Yeah, I couldn't work out a way of generating a patch which removes a
> zero-length file, so that's there as a reminder to ask Linus to remove the
> thing by hand.
> 
This works :

--- linux-2.6.12-rc4-mm1-orig/include/asm-um/elf.h	2005-05-14 12:54:27.000000000 +0200
+++ linux-2.6.12-rc4-mm1/include/asm-um/elf.h	2005-05-15 11:39:28.000000000 +0200
@@ -0,0 +1 @@
+
--- linux-2.6.12-rc4-mm1/include/asm-um/elf.h	2005-05-15 11:39:28.000000000 +0200
+++ /dev/null	2005-05-15 11:17:24.000000000 +0200
@@ -1 +0,0 @@
-


--
Jesper Juhl


