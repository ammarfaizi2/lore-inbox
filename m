Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVCBXIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVCBXIh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVCBXHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:07:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49928 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261313AbVCBXGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:06:52 -0500
Date: Wed, 2 Mar 2005 23:06:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050302230634.A29815@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>; from torvalds@osdl.org on Wed, Mar 02, 2005 at 02:21:38PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 02:21:38PM -0800, Linus Torvalds wrote:
> In other words, we'd have an increasing level of instability with an odd 
> release number, depending on how long-term the instability is.
> 
>  - 2.6.<even>: even at all levels, aim for having had minimally intrusive 
>    patches leading up to it (timeframe: a week or two)
> 
> with the odd numbers going like:
> 
>  - 2.6.<odd>: still a stable kernel, but accept bigger changes leading up 
>    to it (timeframe: a month or two).
>  - 2.<odd>.x: aim for big changes that may destabilize the kernel for 
>    several releases (timeframe: a year or two)
>  - <odd>.x.x: Linus went crazy, broke absolutely _everything_, and rewrote
>    the kernel to be a microkernel using a special message-passing version 
>    of Visual Basic. (timeframe: "we expect that he will be released from 
>    the mental institution in a decade or two").

This sounds good, until you realise that some of us have been sitting
on about 30 patches for at least the last month, because we where
following your guidelines about the -rc's.  Things like adding support
for new ARM machines and other devices, dynamic tick support for ARM,
etc.

If I'm going to have to sit on this stuff for another month, it'll bit
rot rather badly, and I might as well throw away all these patches now
and ask people not to send stuff other than pure bug fixes.

A slightly bigger problem is that I'm in the middle of merging a large
chunk of these for you right now, and at least Andrew has already pulled
some of these from my BK repo.

If we are going to do this, can we start it post 2.6.12 please?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
