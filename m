Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUBDX0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbUBDX0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:26:04 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3200 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264929AbUBDXZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:25:52 -0500
Date: Thu, 5 Feb 2004 00:24:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kgdb support in vanilla 2.6.2
Message-ID: <20040204232447.GC256@elf.ucw.cz>
References: <20040204230133.GA8702@elf.ucw.cz> <20040204152137.500e8319.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204152137.500e8319.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It seems that some kgdb support is in 2.6.2-linus:
> 
> Lots of architectures have had in-kernel kgdb support for a long time. 
> Just none of the three which I use :(
> 
> I wouldn't support inclusion of i386 kgdb until it has had a lot of
> cleanup, possible de-featuritisification and some thought has been applied
> to splitting it into arch and generic bits.  It's quite a lot of work.

What about Amit's kgdb?

It's a *lot* cleaner. It does not have all the features (kgdb-eth is
not yet ready for prime time). Would you accept that?

Oh and it is already split into arch-dependend and arch-independend
parts, plus it has cleanly separated i/o methods...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
