Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVBZL3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVBZL3W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 06:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVBZL3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 06:29:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64776 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261164AbVBZL3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 06:29:19 -0500
Date: Sat, 26 Feb 2005 11:29:15 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>, Paulo Marques <pmarques@grupopie.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: ARM undefined symbols.  Again.
Message-ID: <20050226112915.B1816@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Paulo Marques <pmarques@grupopie.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
References: <20050209104053.A31869@flint.arm.linux.org.uk> <20050213172940.A12469@flint.arm.linux.org.uk> <4210A345.6030304@grupopie.com> <20050225194823.A27842@flint.arm.linux.org.uk> <Pine.LNX.4.58.0502251158280.9237@ppc970.osdl.org> <20050225202349.C27842@flint.arm.linux.org.uk> <Pine.LNX.4.58.0502251227480.9237@ppc970.osdl.org> <20050225222720.D27842@flint.arm.linux.org.uk> <Pine.LNX.4.58.0502251444590.9237@ppc970.osdl.org> <20050226111748.A1816@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050226111748.A1816@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sat, Feb 26, 2005 at 11:17:48AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 11:17:48AM +0000, Russell King wrote:
> So, I have to do _something_ to ensure that we have a reasonable status
> quo in place.  Correction: _I_ don't have to do anything at all if I
> don't care about Linux kernels standing a chance of being built correctly
> by less experienced developers using buggy toolchains.  Then again, maybe
> _that_ is the correct approach.

Just to make it 100% clear: I don't particularly like to work around
the shortcomings of the ARM toolchain by adding hacks to the kernel.
It should be first and foremost up to the toolchain people to fix the
problem.  If someone maintaining the ARM toolchain could be persuaded
to maintain a bugfix only branch, this would be a huge step forwards.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
