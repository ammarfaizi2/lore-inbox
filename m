Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUFJVke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUFJVke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 17:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUFJVkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 17:40:33 -0400
Received: from the-village.bc.nu ([81.2.110.252]:54657 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263093AbUFJVk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 17:40:27 -0400
Subject: Re: PATCH: 2.6.7-rc3 drivers/char/drm/gamma_dma.c: several
	user/kernel pointer bugs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@linux.ie>
Cc: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406101044130.12229@skynet>
References: <1086821620.32053.120.camel@dooby.cs.berkeley.edu>
	 <Pine.LNX.4.58.0406101044130.12229@skynet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1086899821.3669.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 10 Jun 2004 21:37:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-06-10 at 10:46, Dave Airlie wrote:
> okay I've checked this into the drm bk tree and DRM CVS, I've no way to
> test it apart from visual inspection and it compiles, I've asked Linus to
> sync the drm tree again, I probably need to add some __user annotations in
> a few places..

I've got an Oxygen GMX somewhere, but last time I investigated the
drivers didn't work anyway. Not that fixing the security bits isnt a
good idea regardless.

I'll try and test it at some point

