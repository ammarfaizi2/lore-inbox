Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVLCWkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVLCWkb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 17:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVLCWkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 17:40:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13834 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751294AbVLCWka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 17:40:30 -0500
Date: Sat, 3 Dec 2005 23:40:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203224030.GN31395@stusta.de>
References: <20051203135608.GJ31395@stusta.de> <20051203205911.GX18919@marowsky-bree.de> <20051203211329.GC25015@redhat.com> <20051203211810.GY18919@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051203211810.GY18919@marowsky-bree.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 10:18:10PM +0100, Lars Marowsky-Bree wrote:
> On 2005-12-03T16:13:29, Dave Jones <davej@redhat.com> wrote:
> 
> > The big problem is though that we don't typically find out that
> > we've regressed until after a kernel update is in the end-users hands.
> > 
> > In many cases, submitters of changes know that things are going
> > to break. Maybe we need a policy that says changes requiring userspace updates
> > need to be clearly documented in the mails Linus gets (Especially if its
> > a git pull request), so that when the next point release gets released,
> > Linus can put a section in the announcement detailing what bits
> > of userspace are needed to be updated.
> 
> True, but this first block doesn't really qualify as a "regression".
> Yes, a clearer-than-crystal documentation of "this kernel requires
> user-space component foo to be at least x.y.z if feature bar is used"
> would go a long way.
> 
> And if then user-space itself was tolerant of at least version N and
> N-1, then users could even roll back one kernel version if problems
> arise.
> 
> Both of these are documentation and user-space issues, and don't much
> depend on changes to kernel development model.
>...

One effect that you mustn't underestimate is that if people had to got 
to N-1 for two or three different N due to different regressions in 
different kernels, they might decide to stay with kernel version M even 
though kernel M+10 might have been released and version M lacks tons of 
security fixes.

> Sincerely,
>     Lars Marowsky-Brée <lmb@suse.de>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

