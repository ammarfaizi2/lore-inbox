Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUD1Ull@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUD1Ull (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUD1UDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:03:13 -0400
Received: from mail14.atl.registeredsite.com ([64.224.219.88]:24139 "EHLO
	mail14.atl.registeredsite.com") by vger.kernel.org with ESMTP
	id S261380AbUD1TTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:19:23 -0400
Date: Wed, 28 Apr 2004 15:18:41 -0400
From: Vincent C Jones <vcjones@NetworkingUnlimited.com>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6-rc3
Message-ID: <20040428191841.GA4449@NetworkingUnlimited.com>
References: <1PMQ9-5K6-3@gated-at.bofh.it> <20040428144801.B3708149A6@x23.networkingunlimited.com> <20040428160057.GA2252@mars.ravnborg.org> <408FE8C4.33B3BDB4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408FE8C4.33B3BDB4@users.sourceforge.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 08:24:20PM +0300, Jari Ruusu wrote:
> Sam Ravnborg wrote:
> > On Wed, Apr 28, 2004 at 10:48:01AM -0400, Vincent C Jones wrote:
> > >
> > > loop-AES 2.0g has refused to compile since 2.6.6-rc1. No problems up
> > > through 2.6.5. The make script cd's to the kernel source root, then
> > > can't find any of the kernel include files, and it's all downhill from
> > > there...
> > 
> > This is an external module - right?
> > Could you mail me privately the Makefile used, or even better
> > the full package (or link to it).
> 
> Full package:
> http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.0g.tar.bz2
> 
> Patch to fix build problem:
> http://loop-aes.sourceforge.net/updates/loop-AES-v2.0g-20040412.diff.bz2
> 
> New version of loop-AES will be released shortly after final 2.6.6 kernel is
> released.
> 
> -- 
> Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD

Thanks much for the quick response. With the loop-AES makefile patched,
loop-AES and 2.6.6-rc3 are happy together.

One last question: Is there a reason there is no mention of the
compile problem or presence of a patch on the loop-AES sourceforge home
page (http://sourceforge.net/projects/loop-aes/)? Or is this common
knowledge that everyone is supposed to know about sourceforge projects?
At least with this thread, Google searches will no longer come up empty.

Now all I need is an APM implementation which suspends while on A/C
power and I can stop playing with kernel releases and concentrate
on work.

Thanks again!

Vince

-- 
Dr. Vincent C. Jones, PE              Expert advice and a helping hand
Computer Network Consultant           for those who want to manage and
Networking Unlimited, Inc.            control their networking destiny
14 Dogwood Lane, Tenafly, NJ 07670
http://www.networkingunlimited.com
VCJones@NetworkingUnlimited.com  +1 201 568-7810  Fax: +1 201 568-7269 
