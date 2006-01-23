Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWAWNzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWAWNzJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 08:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWAWNzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 08:55:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50879 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751459AbWAWNzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 08:55:07 -0500
Date: Mon, 23 Jan 2006 14:54:28 +0100
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: Ville Herva <vherva@vianova.fi>
Cc: Heinz Mauelshagen <mauelshagen@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>, Neil Brown <neilb@suse.de>,
       Phillip Susi <psusi@cfl.rr.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060123135428.GA2801@redhat.com>
Reply-To: mauelshagen@redhat.com
References: <43D02033.4070008@cfl.rr.com> <17360.9233.215291.380922@cse.unsw.edu.au> <20060120183621.GA2799@redhat.com> <20060120225724.GW22163@marowsky-bree.de> <20060121000142.GR2801@redhat.com> <20060121000344.GY22163@marowsky-bree.de> <20060121000806.GT2801@redhat.com> <20060121001311.GA22163@marowsky-bree.de> <20060123094418.GX2801@redhat.com> <20060123125420.GE1686@vianova.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123125420.GE1686@vianova.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 02:54:20PM +0200, Ville Herva wrote:
> On Mon, Jan 23, 2006 at 10:44:18AM +0100, you [Heinz Mauelshagen] wrote:
> > > 
> > > I use the regularly to play with md and other stuff...
> > 
> > Me too but for production, I want to avoid the
> > additional stacking overhead and complexity.
> > 
> > > So I remain unconvinced that code duplication is worth it for more than
> > > "hark we want it so!" ;-)
> > 
> > Shall I remove you from the list of potential testers of dm-raid45 then ;-)
> 
> Heinz, 
> 
> If you really want the rest of us to convert from md to lvm, you should
> perhaps give some attention to thee brittle userland (scripts and and
> binaries).

Sure :-)

> 
> It is very tedious to have to debug a production system for a few hours in
> order to get the rootfs mounted after each kernel update. 
> 
> The lvm error messages give almost no clue on the problem. 
> 
> Worse yet, problem reports on these issues are completely ignored on the lvm
> mailing list, even when a patch is attached.
> 
> (See
>  http://marc.theaimsgroup.com/?l=linux-lvm&m=113775502821403&w=2
>  http://linux.msede.com/lvm_mlist/archive/2001/06/0205.html
>  http://linux.msede.com/lvm_mlist/archive/2001/06/0271.html
>  for reference.)

Hrm, those are initscripts related, not lvm directly

> 
> Such experience gives an impression lvm is not yet ready for serious
> production use.

initscripts/initramfs surely need to do the right thing
in case root is on lvm.

> 
> No offense intended, lvm kernel (lvm1 nor lvm2) code has never given me
> trouble, and is probably as solid as anything. 

Alright.
Is the initscript issue fixed now or still open ?
Had you filed a bug against the distros initscripts ?

> 
> 
> -- v -- 
> 
> v@iki.fi
> 
> PS: Speaking of debugging failing initrd init scripts; it would be nice if
> the kernel gave an error message on wrong initrd format rather than silently
> failing... Yes, I forgot to make the cpio with the "-H newc" option :-/.

-- 

Regards,
Heinz    -- The LVM Guy --

*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat GmbH
Consulting Development Engineer                   Am Sonnenhang 11
Cluster and Storage Development                   56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
