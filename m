Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290827AbSBFVhO>; Wed, 6 Feb 2002 16:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290823AbSBFVhE>; Wed, 6 Feb 2002 16:37:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8452 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290820AbSBFVgw>;
	Wed, 6 Feb 2002 16:36:52 -0500
Message-ID: <3C61A1F2.434717D@mandrakesoft.com>
Date: Wed, 06 Feb 2002 16:36:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Applying 2.5.4-pre1 patch
In-Reply-To: <3C6119E2.2060504@wanadoo.fr> <3C619586.92EAED50@mandrakesoft.com> <3C619927.2020601@wanadoo.fr> <3C619C71.5D2A710F@mandrakesoft.com> <3C61A0F7.2020302@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet wrote:
> 
> Jeff Garzik wrote:
> > Pierre Rousselet wrote:
> >
> >>Jeff Garzik wrote:
> >>
> >>>Pierre Rousselet wrote:
> >>>
> >>>
> >>>>Patching drivers/char/gameport with /dev/null doesn't work for me. What
> >>>>is the trick ?
> >>>>
> >>>>
> >>>/dev/null indicates a new, or a removed, file.
> >>>
> >>'patch -p0 < patch' is confused by this : "sure you want to delete this
> >>file ?"
> >>
> >
> > Linus's patches should be applied with -p1.
> 
> OK, it works. But you cannot use the patch-file outside of the linux
> directory.

This is normal with everybody else's patches, such as Alan's.  Linus is
just sorta catching up.


> It means also the patch-kernel script is dead.

Did you actually try patch-kernel, from inside the kernel dir?  It
appears to use 'p1' to apply patches.

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
