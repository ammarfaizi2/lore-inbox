Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbTDQXSc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 19:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTDQXSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 19:18:32 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:43662 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262690AbTDQXSb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 19:18:31 -0400
Date: Fri, 18 Apr 2003 01:29:42 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.67-ac1 IDE - fix Taskfile IOCTLs
In-Reply-To: <1050618406.32652.10.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0304180127100.574-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17 Apr 2003, Alan Cox wrote:

> On Gwe, 2003-04-18 at 00:16, Bartlomiej Zolnierkiewicz wrote:
> > Hey,
> >
> > This time 5 incremental patches:
> >
> > 1       - Fix PIO handlers for Taskfile ioctls.
> > 2a + 2b - Taskfile and flagged Taskfile PIO handlers unification.
> > 3       - Map HDIO_DRIVE_CMD ioctl onto taskfile.
> > 4       - Remove dead ide_diag_taskfile() code.
> >
> > [ More comments inside patches. ]
>
> I'll take a look at them for ac3. Can I roll in 1/2a-b and 4 and skip
> the experimental one for ac3 ?

Sure, you can also include 3 because by old function is used by default,
to use the new one CONFIG_IDE_TASKFILE_IO has to be turned on...

