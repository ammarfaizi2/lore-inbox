Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWE2SLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWE2SLb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 14:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWE2SLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 14:11:31 -0400
Received: from mail.linicks.net ([217.204.244.146]:13746 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751160AbWE2SLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 14:11:30 -0400
From: Nick Warne <nick@linicks.net>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: Question on Space.c
Date: Mon, 29 May 2006 19:11:25 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200605291849.04769.nick@linicks.net> <9a8748490605291105v42e66303pbb45fdccec3a13e4@mail.gmail.com>
In-Reply-To: <9a8748490605291105v42e66303pbb45fdccec3a13e4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605291911.25836.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 May 2006 19:05, Jesper Juhl wrote:
> On 29/05/06, Nick Warne <nick@linicks.net> wrote:
> > I saw Space.o being build, and seeing as it is Capitalised thought I
> > would see why, and maybe a patch to make it all lower case.
>
> [snip]
>
> > I have looked though docs and googled as to why this One File Is Like
> > This to no avail?  Convention?
>
> The normal convention is for filenames to be all lowercase except for
> some special ones like "Makefile", "Kconfig", "README" etc (although
> there are a few exceptions,for source files, like
> drivers/scsi/NCR5380.c, include/asm-m68knommu/MC68328.h,
> drivers/block/DAC960.c and others).
> To find some more, try this in the kernel source dir : find ./ -name
> "[A-Z]*"
>
> It would make sense to me personally to rename this one, but it's not
> my call and besides it'll open a whole can of worms about whether or
> not to rename the other ones...

Well, I don't think so.  Apart from the really conventional file names 
(Makefile et al), the others you mentioned are abbreviations*, so it is 
obvious.  Now Ncr5380.c would be a different kettle of fish...

Nick
* abbreviation: a long word used to describe a short word used in place of a 
long word.
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
