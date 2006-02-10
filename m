Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWBJAco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWBJAco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWBJAcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:32:43 -0500
Received: from ns1.suse.de ([195.135.220.2]:11456 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750874AbWBJAcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:32:43 -0500
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: Cleanup possibility in asm-i386/string.h
Date: Fri, 10 Feb 2006 01:23:35 +0100
User-Agent: KMail/1.8.2
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
References: <200602071215.46885.ak@suse.de> <Pine.LNX.4.61.0602071336060.30994@scrub.home> <20060210000523.GE3524@stusta.de>
In-Reply-To: <20060210000523.GE3524@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602100123.36077.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 01:05, Adrian Bunk wrote:
> On Tue, Feb 07, 2006 at 01:39:50PM +0100, Roman Zippel wrote:
> > Hi,
> > 
> > On Tue, 7 Feb 2006, Andi Kleen wrote:
> > 
> > > > This means you define a prototype for the builtin function and not for the 
> > > > normal function. I'm not sure this is really intended.
> > > 
> > > What good would be a prototype for a symbol that is defined to a different symbol?
> > 
> > The point is you define a prototype for a builtin function, I'm not sure 
> > that's a good thing to do.
> > Actually I'd prefer to remove -ffreestanding again, especially because it
> > disables builtin functions, which we have to painfully enable all again 
> > one by one, instead of leaving it just to gcc.
> 
> I remember playing with using more gcc builtins in the kernel some time 
> ago, and some gcc builtin used a different library function, which was a 
> function the kernel did not supply.

It works fine on x86-64. If something is missing it can be also supplied.

-Andi

