Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751723AbWF2Eov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbWF2Eov (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 00:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWF2Eov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 00:44:51 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:6922 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751722AbWF2Eov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 00:44:51 -0400
From: "Matt LaPlante" <laplam@rpi.edu>
To: "'Randy.Dunlap'" <rdunlap@xenotime.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [Patch] Attack of "the the"s in /arch
Date: Thu, 29 Jun 2006 00:44:12 -0400
Message-ID: <001f01c69b36$aabf4980$fe01a8c0@cyberdogt42>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcabNaDNPSmoB8/xTb6tTLZAvsJbqQAAMz0g
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
In-Reply-To: <20060628213924.50f29a4a.rdunlap@xenotime.net>
X-Spam-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 00:44:22 -0400
	(not processed: message from trusted or authenticated source)
X-Return-Path: laplam@rpi.edu
X-Envelope-From: laplam@rpi.edu
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 00:44:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Randy.Dunlap [mailto:rdunlap@xenotime.net]
> Sent: Thursday, June 29, 2006 12:39 AM
> To: Matt LaPlante
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [Patch] Attack of "the the"s in /arch
> 
> On Thu, 29 Jun 2006 00:06:25 -0400 Matt LaPlante wrote:
> 
[me]
> 
> Hi Matt,
> 
> The only problem that I see is that your mail client or server
> breaks some (longer) lines where they should not be split,
> so the patch cannot be applied with 'patch'.
> 
> E.g.:
> 
> > diff -ru a/arch/arm/mach-lh7a40x/arch-lpd7a40x.c
> > b/arch/arm/mach-lh7a40x/arch-lpd7a40x.c
> > --- a/arch/arm/mach-lh7a40x/arch-lpd7a40x.c	2006-06-28
> > 23:20:26.000000000 -0400
> > +++ b/arch/arm/mach-lh7a40x/arch-lpd7a40x.c	2006-06-28
> > 23:45:49.000000000 -0400
> 
> Above should be 3 lines:
> diff ...
> --- ...
> +++ ...
> 
> but it is broken into 6 lines.  Your options are (e.g.):
> 
> - use (some) Linux client to send email (not all are good for patches)
> - on Windows:  use thunderbird or sylpheed or (last resort, not
>   really good since it makes reviewing & sending feedback on patches
>   more difficult on us) is to use attachments.  Please don't go for
>   the last resort.
> 
> Sylpheed (sylpheed.good-day.net) supports inserting a file into
> the email body, which is perfect (at least on Linux it does,
> I hope that it does on Windows too).
> Tbird is more of a problem, but can do done.  If you care to use
> tbird, take a look at
> http://mbligh.org/linuxdocs/Email/Clients/Thunderbird
> and
> http://lkml.org/lkml/2005/12/27/191
> and
> http://lists.osdl.org/pipermail/kernel-janitors/2006-June/006478.html
> for details on how to use it (on Linux, hopefully Windows is
> about the same).
> 
> Try not to use attachments...
> 
> Oh, there are other split lines in your patch.  After joining all of
> the split lines (10-12 of them), the patch applies cleanly except
> for one file.  I'm applying it to 2.6.17-git13.  What kernel version
> did you use to make it?  You should use a very current version.
> 
> ---
> ~Randy

I used git13 as well.  I've actually got some more typo fixes ready to
submit, so I will find a better mailing method separately, then post them.
Thanks for the feedback.

-
Matt


