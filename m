Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbUBPRRS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbUBPRRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:17:18 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:47752 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265678AbUBPRRN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:17:13 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Timothy Miller <miller@techsource.com>
Subject: Re: 2.4.24 problems [WAS: Re: IDE DMA problem  [WAS: Re: Getting lousy NFS + tar-pipe throughput on 2.4.20]]
Date: Mon, 16 Feb 2004 18:20:32 +0100
User-Agent: KMail/1.5.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Balaji Calidas <balaji@techsource.com>
References: <402D6262.90301@techsource.com> <200402140154.54307.bzolnier@elka.pw.edu.pl> <4030F94F.1000900@techsource.com>
In-Reply-To: <4030F94F.1000900@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402161820.32901.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 of February 2004 18:09, Timothy Miller wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Saturday 14 of February 2004 01:16, Timothy Miller wrote:
> >
> >   Does 2.4.20 not work well with the KT600
> >
> >>chipset?
> >
> > It doesn't, upgrade to 2.4.24.
>
> Ok, so we tried that.  That caused all sorts of havoc, most of which we
> might be able to figure out.  It seems that RedHat's utilities and stuff
> don't get along well with 2.4.24 if all you do is just boot the new
> kernel.  Seems a bunch of other stuff needs to be upgraded.
>
> Also, 'root=LABEL=/' doesn't work anymore in grub.conf, and there seems
> to be no way to enable it.  Is this a RedHat only thing?

This feature is not present in vanilla kernels.

> In any event, when we managed to get it to boot, it absolutely did NOT
> fix the DMA problem with the KT600.  Trying to enable it with hdparm
> still says "Operation not permitted".  We spend a LOT of time trying to
> make sure we got the kernel configured right with all of the right
> options, etc., but we're still without IDE DMA.
>
> Any further suggestions?

Do you have VIA IDE driver compiled in?
CONFIG_BLK_DEV_VIA82CXXX=y

If so, please send output of 'dmesg' command.

--bart

