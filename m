Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265034AbUD3Akt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265034AbUD3Akt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 20:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbUD3Akt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 20:40:49 -0400
Received: from sol.linkinnovations.com ([203.94.173.142]:26497 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S265034AbUD3Aks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 20:40:48 -0400
Date: Fri, 30 Apr 2004 10:39:52 +1000
From: CaT <cat@zip.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata + siI3112 + 2.6.5-rc3 hang
Message-ID: <20040430003951.GB6145@zip.com.au>
References: <20040429234258.GA6145@zip.com.au> <200404300208.32830.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404300208.32830.bzolnier@elka.pw.edu.pl>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 02:08:32AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Probably your drive needs mod15write quirk. please try this.

The system hung linking the kernel. :) I'll try compiling again
either in 2-3hrs time or 6-7 depending on when I can get home.

Figures. :/
> On Friday 30 of April 2004 01:42, CaT wrote:
> > 2.4.25 aswell and has occured when I did a mke2fs -c on a partition
> > and (twice) with hdparm -tT. The first time hdparm works fine and
> > infact clocks the HD at 62MB/s (wowsers!), but the second time the
> > system hangs.
> 
> It will go down with a quirk :( blame SiI for not providing chipset errata.

Actively doing so as I glare at my dead ssh connection. :)

> > scsi0? I thought it detected it at scsi1? This reminds me. The MB has
> > the connector labeled as SATA1 but on bootup it's detected as the primary
> > SATA drive.
> 
> libata has zero knowledge about legacy ordering and it's GOOD thing.

Not complaining. This is all new to me and I'm trying to get it all
straight in my head (one of the reasons why I went with a SATA drive
rather then PATA).

-- 
    Red herrings strewn hither and yon.
