Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbUKSOM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUKSOM0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 09:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUKSOLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 09:11:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42246 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261417AbUKSOLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 09:11:18 -0500
Date: Fri, 19 Nov 2004 15:11:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, David Woodhouse <dwmw2@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: RFC: let x86_64 no longer define X86
Message-ID: <20041119141116.GB5390@stusta.de>
References: <20041119005117.GM4943@stusta.de> <20041119085132.GB26231@wotan.suse.de> <419DC922.1020809@pobox.com> <20041119103418.GB30441@wotan.suse.de> <1100863700.21273.374.camel@baythorne.infradead.org> <20041119115539.GC21483@wotan.suse.de> <1100865050.21273.376.camel@baythorne.infradead.org> <20041119120549.GD21483@wotan.suse.de> <419DE33E.2000208@pobox.com> <20041119121909.GF21483@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119121909.GF21483@wotan.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 01:19:10PM +0100, Andi Kleen wrote:
> On Fri, Nov 19, 2004 at 07:12:46AM -0500, Jeff Garzik wrote:
> > Andi Kleen wrote:
> > >I don't know details about the driver, but it's not enabled on x86-64 
> > >because x86-64 doesn't have ISA set.
> > 
> > 
> > which I disagree with.  CONFIG_ISA should include southbridge devices 
> > behind a PCI<->ISA bridge.  There is zero value to a more stricter 
> > "there is a physical ISA bus in this machine" definition.
> 
> There is. It gets rid of many tens of drivers that are not and will never
> be 64bit clean and have a snowball in hell chances to work on x86-64.
>...

If this was correctly annotated with (!64BIT || BROKEN), such a broken 
driver wasn't offered on Alpha, too.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

