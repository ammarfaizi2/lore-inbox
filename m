Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161056AbVLJTtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbVLJTtI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 14:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbVLJTtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 14:49:08 -0500
Received: from mail.autoweb.net ([198.172.237.26]:11481 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1161056AbVLJTtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 14:49:07 -0500
Date: Sat, 10 Dec 2005 14:48:47 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051210194846.GA11235@mythryan2.michonline.com>
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203152339.GK31395@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 04:23:39PM +0100, Adrian Bunk wrote:
> On Sat, Dec 03, 2005 at 03:36:38PM +0100, Arjan van de Ven wrote:
> 
> > If the current model doesn't work as you claim it doesn't, then maybe
> > the model needs finetuning. Right now the biggest pain is the userland
> > ABI changes that need new packages; sometimes (often) for no real hard
> > reason. Maybe we should just stop doing those bits, they're not in any
> > fundamental way blocking general progress (sure there's some code bloat
> > due to it, but I guess we'll just have to live with that).
> 
> IOW, we should e.g. ensure that today's udev will still work flawlessly 
> with kernel 2.6.30 (sic)?
> 
> This could work, but it should be officially announced that e.g. a 
> userspace running kernel 2.6.15 must work flawlessly with _any_ future 
> 2.6 kernel.
> 
> For how many years do you think we will be able to ensure that this will 
> stay true?

I'd rather see the statement that if a kernel 2.6.N requires a userspace
update (udev, alsa, whatever), that the new userspace works correctly on
2.6.(N-10).

I think that is the bit of the problem that has been really frustrating
to the people that have run into it.

(I think that is the complaint Dave Jones made during his OLS keynote,
and I've seen a similar complaint about udev, though the udev issue
may have been Debian specific.)

-- 

Ryan Anderson
  sometimes Pug Majere
