Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266578AbRGLUqw>; Thu, 12 Jul 2001 16:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266573AbRGLUqm>; Thu, 12 Jul 2001 16:46:42 -0400
Received: from [194.213.32.142] ([194.213.32.142]:16900 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266580AbRGLUqW>;
	Thu, 12 Jul 2001 16:46:22 -0400
Date: Thu, 12 Jul 2001 10:37:34 +0000
From: Pavel Machek <pavel@suse.cz>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org
Subject: Re: What are rules for acpi_ex_enter_interpreter?
Message-ID: <20010712103732.A35@toy.ucw.cz>
In-Reply-To: <20010704033807.A1469@ppc.vc.cvut.cz> <20010704163313.A10794@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010704163313.A10794@ppc.vc.cvut.cz>; from vandrove@vc.cvut.cz on Wed, Jul 04, 2001 at 04:33:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >   I did NOT verified other callers of acpi_walk_namespace... And there
> > is still some problem left, as although now S5 is listed as available,
> > poweroff still does nothing instead of poweroff.
> 
> Replying to myself, after following change in additon to acpi_ex_...
> poweroff on my machine works. It should probably map type 0 => 0, 3 => 1
> and 7 => 2, but it is hard to decide without VIA datasheet, so change
> below is minimal change needed to get poweroff through ACPI to work on my 
> ASUS A7V.

You should printk loudly during bootup, so people know their hw is b0rken.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

