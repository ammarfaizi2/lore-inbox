Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWHaI6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWHaI6X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 04:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWHaI6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 04:58:23 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:19691 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1751051AbWHaI6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 04:58:22 -0400
Date: Thu, 31 Aug 2006 11:55:46 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm3
Message-ID: <20060831095546.GA13170@ens-lyon.fr>
References: <39A055DD9BDD564FAF89ABDA9EB5F58512A76FE4@scsmsx413.amr.corp.intel.com> <20060830111507.B30823@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060830111507.B30823@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 11:15:08AM -0700, Venkatesh Pallipadi wrote:
> On Mon, Aug 28, 2006 at 07:00:33PM -0700, Pallipadi, Venkatesh wrote:
> >  
> > 
> > >-----Original Message-----
> > >From: Benoit Boissinot [mailto:bboissin@gmail.com] 
> > >Sent: Sunday, August 27, 2006 9:00 AM
> > >To: Andrew Morton
> > >Cc: linux-kernel@vger.kernel.org; Pallipadi, Venkatesh; Brown, Len
> > >Subject: Re: 2.6.18-rc4-mm3
> > >
> > >On 8/27/06, Andrew Morton <akpm@osdl.org> wrote:
> > >>
> > >> 
> > >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2
> > >.6.18-rc4/2.6.18-rc4-mm3/
> > >>
> > >>  git-acpi.patch
> > >
> > >commit f62d31ee2f2f453b07107465fea54540cab418eb broke my laptop
> > >(pentium M, dell D600).
> > >I can reliably get a hard lockup (no sysrq) when modprobing ehci_hcd
> > >and uhci_hci. It works when reverting the changeset.
> > >
> > >I can provide cpuinfo or dmesg if necessary.
> > >
> 
> Attached is the updated patch. Please test it on your system whenever you get
> a chance. ACPI C-states and /proc/acpi/processor/*/power should show similar
> numbers with or without this patch. It should not hang as before.
> 

It looks like it's running fine! So far I didn't have any hang whereas
it was completely reproducable before.

thanks,

Benoit
-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
