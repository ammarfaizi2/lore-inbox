Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVECAnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVECAnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 20:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVECAnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 20:43:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:23458 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261259AbVECAnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 20:43:42 -0400
Date: Mon, 2 May 2005 17:44:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: jdike@addtoit.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/22] UML - Include the linker script rather than
 symlink it
Message-Id: <20050502174405.0c8cad31.akpm@osdl.org>
In-Reply-To: <20050503002521.GA18977@parcelfarce.linux.theplanet.co.uk>
References: <200505012112.j41LC9fa016385@ccure.user-mode-linux.org>
	<20050502170654.248b11ea.akpm@osdl.org>
	<20050503002521.GA18977@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@parcelfarce.linux.theplanet.co.uk> wrote:
>
> On Mon, May 02, 2005 at 05:06:54PM -0700, Andrew Morton wrote:
> > That file doesn't exist and I think this patch doesn't want to patch it
> > anyway.
> > 
> > I'll just drop the vmlinux.lds.S chunk...
> 
> Correct patch is on ftp.linux.org.uk/pub/people/viro/UM0-uml-ldscript-RC12-rc3

OK...

There's a bit of a tangle going on in arch/um/kernel/Makefile, but it's
fairly simple stuff.

I put a rolled-up patch against 2.6.12-rc3 at
http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2 if someone wants to
check it all.

Is this all considered post-2.6.12 material?
