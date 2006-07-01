Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWGAWWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWGAWWu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 18:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWGAWWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 18:22:49 -0400
Received: from terminus.zytor.com ([192.83.249.54]:39869 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750907AbWGAWWt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 18:22:49 -0400
Message-ID: <44A6F598.7090601@zytor.com>
Date: Sat, 01 Jul 2006 15:22:16 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Jeff Bailey <jbailey@ubuntu.com>,
       "H. Peter Anvin" <hpa@zytor.com>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060630181131.GA1709@elf.ucw.cz> <44A5AE17.4080106@tls.msk.ru> <44A5B07E.9040007@zytor.com> <1151751417.2553.8.camel@localhost.localdomain> <20060701150506.GA10517@thunk.org>
In-Reply-To: <20060701150506.GA10517@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> 
> Personally, I would be happier with keeping things like suspend2 in
> the kernel, since I don't think the hellish compatibility problems
> with non-reviewed kernel functionality that has been ejected into
> userspace is really worth it --- but if we *are* going to go down the
> route pushing everything into userspace, it is going to be critical
> that distro's buy into using a kernel initialization system which is
> shipped with the kernel, and can be updated without being tied a
> particular distro's non-standard "value add".  Maybe that means we
> need to have hooks so that the distro's can add their non-standard
> "value add" without breaking the ability for users to upgrade to newer
> kernels.

That would be my feeling.  The ability to overlay initramfs is essential 
for that.

 > But either way, we're going to have to decide which way
> we're going to go, and if we're going to go down the blind
> in-userspace-good-in-kernel-bad approach, the distro's are going to
> have to cooperate or it's going to be a mess.

Of course.

	-hpa

