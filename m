Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVDDHKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVDDHKq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 03:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVDDHKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 03:10:45 -0400
Received: from blackhole.adamant.ua ([212.26.128.69]:57357 "EHLO
	blackhole.adamant.ua") by vger.kernel.org with ESMTP
	id S261583AbVDDHKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 03:10:11 -0400
Date: Mon, 4 Apr 2005 10:10:03 +0300
From: Alexander Trotsai <mage@adamant.ua>
To: Tejun Heo <htejun@gmail.com>
Cc: John Lash <jkl@sarvega.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Re: sata_sil Mod15Write quirk workaround patch for vanilla kernel avaialble.
Message-ID: <20050404071002.GI4383@blackhole.adamant.ua>
References: <424C10C3.9080102@gmail.com> <20050331111044.4a3672cd@homer.sarvega.com> <424C7EF0.5000206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <424C7EF0.5000206@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 07:51:28AM +0900, Tejun Heo wrote:
TH>  Hello, John.
TH> 
TH> John Lash wrote:
TH> >On Fri, 01 Apr 2005 00:01:23 +0900
TH> >Tejun Heo <htejun@gmail.com> wrote:
TH> >
TH> >
TH> >>Hello, guys.
TH> >>
TH> >>I  generated m16w workaround patch for 2.6.11.6 (by just removing two
TH> >>lines :-) and set up a page regarding m15w quirk and the workaournd.
TH> >>I'm planning on updating m15w patch against the vanilla tree until it
TH> >>gets into the mainline so that impatient users can try out and it gets
TH> >>more testing.
TH> >>
TH> >>http://home-tj.org/m15w
TH> >>
TH> >>Thanks.
TH> >>
TH> >>-- 
TH> >>tejun
TH> >>
TH> >
TH> >
TH> >Tejun,
TH> >
TH> >I applied the patch to a clean 2.6.11.6 kernel and got an unresolved
TH> >symbol error for "ATA_TFLAG_LBA". I tried changing that to 
TH> >"ATA_TFLAG_LBA48" and
TH> >it compiles and runs.
TH> >
TH> >So far, no problems. Thanks a lot for the patch.
TH> 
TH>  I'm sorry.  I uploaded the original patch against libata-dev-2.6 tree. 
TH>  The two BUG_ON() lines should just be removed.  I've uploaded fixed 
TH> patch.  Thanks for pointing out.

Thanks
Seems to be worked (I'm install with ide-ata-2.6 patch)
But with heavy read load write performance is very very bad
(near 50-100 KBps)
But I think that is not problem of Silicon card (I have also
to SATA hard drives on Intel onboard SATA controller with
same performance troubles)

-- 
Best regard, Aleksander Trotsai aka MAGE-RIPE aka MAGE-UANIC
My PGP key at ftp://blackhole.adamant.ua/pgp/trotsai.key[.asc]
