Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbTETAbo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTETAbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:31:44 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:9891 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263264AbTETAbk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:31:40 -0400
Date: Tue, 20 May 2003 02:44:12 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Corey Minyard <cminyard@mvista.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add boot command line parsing for the e100 driver
In-Reply-To: <Pine.SOL.4.30.0305200215130.28757-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0305200243380.28757-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 May 2003, Bartlomiej Zolnierkiewicz wrote:
> On Mon, 19 May 2003, Corey Minyard wrote:
>
> > Jeff Garzik wrote:
> >
> > >>instead of adding such horrible cruft Corey did it should just use the
> > >>proper API.
> > >>
> > >>
> > >
> > >An API already exists, and it is source compatible between 2.4 and 2.5:
> > >ethX=.... on the kernel command line.
> > >
> > >The proper patch would pick up options from there.
> > >
> > Can you tell me where this is?  I found the "ether=xxx" and
> > "netdev=xxx", but they are not suitible.  I also could not find
> > "module_parame" anywhere on google or in the kernel.
> >
> > -Corey
>
> :-) module_parm(), look at include/linux/moduleparam.h
> and scsi for usage examples

ugh. s/module_parm/module_param/

--
Bartlomiej

