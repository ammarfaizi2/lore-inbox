Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVBMQrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVBMQrE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 11:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVBMQrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 11:47:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18053 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261276AbVBMQrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 11:47:01 -0500
Date: Sun, 13 Feb 2005 16:46:52 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Jeff Dike <jdike@addtoit.com>
Cc: Vadim Abrossimov <vadim_abrossimov@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uml: support a separate build tree; support USER_OBJS dependencies
Message-ID: <20050213164652.GE8859@parcelfarce.linux.theplanet.co.uk>
References: <opsl43d9yilfdzum@localhost.localdomain> <200502131813.j1DICsnW002251@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502131813.j1DICsnW002251@ccure.user-mode-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2005 at 01:12:54PM -0500, Jeff Dike wrote:
> vadim_abrossimov@yahoo.com said:
> > 1. To support a separate build tree for the um/i386 architecture the
> > following changes have been done: 
> 
> Have a look at 
> 	http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.11-rc3-mm2/patches/cross-build
> 
> That's Al Viro's take on the same problem, plus -j and some other things he
> noted in passing.
> 
> If you could remove the stuff that's common (and flag the overlapping, but 
> different things) from your patch, that would be helpful.

Err...  FWIW, aforementioned patch lacks e.g. vmlinux.lds.S.  The latest
I have on anonftp is ftp.linux.org.uk/pub/people/viro/UML-kbuild; there's
more in my local tree, but that's a separate story.
