Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbULaK4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbULaK4F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 05:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbULaK4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 05:56:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33549 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261628AbULaK4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 05:56:01 -0500
Date: Fri, 31 Dec 2004 10:55:53 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Herbert Poetzl <herbert@13thfloor.at>,
       "Georg C. F. Greve" <greve@fsfeurope.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
Message-ID: <20041231105553.C29868@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Herbert Poetzl <herbert@13thfloor.at>,
	"Georg C. F. Greve" <greve@fsfeurope.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <m3is6k4oeu.fsf@reason.gnu-hamburg> <Pine.LNX.4.58.0412301239160.22893@ppc970.osdl.org> <m3zmzvl9x1.fsf@reason.gnu-hamburg> <Pine.LNX.4.58.0412301418521.22893@ppc970.osdl.org> <20041231041621.GA14321@mail.13thfloor.at> <Pine.LNX.4.58.0412302052430.2280@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0412302052430.2280@ppc970.osdl.org>; from torvalds@osdl.org on Thu, Dec 30, 2004 at 08:53:45PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2004 at 08:53:45PM -0800, Linus Torvalds wrote:
> On Fri, 31 Dec 2004, Herbert Poetzl wrote:
> > 
> > maybe this can provide more information (let me know if
> > you need an ASCII version, I'll transcribe it by hand then)
> 
> Same thing. Some slab corruption causing problems at free time. The 
> real problem happened much earlier, so the oops isn't all that useful. 
> What would be useful is if you can pinpoint what triggers it and/or when 
> it started happening..

2.6.10-rc3 maybe... depending on whether you want to look at this oops
with a proprietary iSCSI module loaded...

http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2004-December/026159.html
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2004-December/026164.html

However, the fact that this person can't reproduce the slab corruption
without this iSCSI module loaded may be telling, but since you're also
chasing such a problem, it may not have anything to do with their iSCSI
stuff.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
