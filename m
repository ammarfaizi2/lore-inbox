Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266351AbUH1WIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266351AbUH1WIb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 18:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUH1WIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 18:08:31 -0400
Received: from hera.cwi.nl ([192.16.191.8]:54977 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S266351AbUH1WI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 18:08:28 -0400
Date: Sun, 29 Aug 2004 00:08:24 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2 mount options doc
Message-ID: <20040828220823.GB2079@apps.cwi.nl>
References: <UTC200408271606.i7RG6tV27596.aeb@smtp.cwi.nl> <Pine.LNX.4.58.0408271104300.14196@ppc970.osdl.org> <20040828011959.GC16444@apps.cwi.nl> <Pine.LNX.4.58.0408271856071.14196@ppc970.osdl.org> <20040828213014.GA2079@apps.cwi.nl> <20040828144630.13df93e0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828144630.13df93e0.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 02:46:30PM -0700, Andrew Morton wrote:
> Andries Brouwer <Andries.Brouwer@cwi.nl> wrote:

> > Updated mount.8, and in the process added a few words to
> >  Documentation/filesystems/ext2.txt too.
> 
> Linus's ext2.txt has recently been updated, so your patch generates 100%
> rejects.

Good - no doubt that means that my update is superfluous already.
Let me see..

Hmm. This new file documents barrier=1 and I did not.
Does that really apply to ext2?

Otherwise the changes agree, except that I documented that since
2.5.46 most defaults are not determined by the kernel but by the
superblock. (So some *'s should be deleted.)

(Will not send a new patch now. Maybe later.)

Andries
