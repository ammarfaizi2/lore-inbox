Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbUAHMBR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 07:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUAHMBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 07:01:17 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55939 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264364AbUAHMA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 07:00:29 -0500
Date: Thu, 8 Jan 2004 13:00:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Patrick Mochel <mochel@osdl.org>
Subject: Re: s3 sleep: Kill obsolete debugging code
Message-ID: <20040108120028.GC31912@atrey.karlin.mff.cuni.cz>
References: <20040102224644.GA466@elf.ucw.cz> <20040108002254.E50AB2C2BB@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108002254.E50AB2C2BB@lists.samba.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > wakeup.S includes some rather nasty, and unneccessary debugging
> > code. (It used to try to flush caches/tlbs; now its totally
> > useless). Please apply,
> > 							Pavel
> 
> Removing asm not really trivial unless the author sent it...

I was author of original debugging code, than Patrick simplified it,
and by now its totaly useless. Anyway it seems that Andrew took the
patch, so it is on its way to linus.
								Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
