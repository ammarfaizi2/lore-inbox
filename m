Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264420AbUA3X24 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 18:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbUA3X24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 18:28:56 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:27332 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264420AbUA3X2x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 18:28:53 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: markus reichelt <mr@lists.notified.de>
Subject: Re: 2.6.1 "clock preempt"?
Date: Sat, 31 Jan 2004 00:32:23 +0100
User-Agent: KMail/1.5.3
References: <1074800554.21658.68.camel@cog.beaverton.ibm.com> <20040123203835.GA518@h00a0cca1a6cf.ne.client2.attbi.com> <20040127213026.GA1315@lists.notified.de>
In-Reply-To: <20040127213026.GA1315@lists.notified.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401310032.23285.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 of January 2004 22:30, markus reichelt wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> timothy parkinson <t@timothyparkinson.com> wrote:
> > * Running with SpeedStep (this is a cpu thing i assume?) could cause
> > this. * Not having DMA enabled on your hard disk(s) could cause this. 
> > See the hdparm utility to enable it.
> > * Incorrect TSC synchronization on SMP systems could cause this.
> > * Anything else?
>
> Yepp:
>
> Jan 27 20:12:12 tatooine kernel: Losing too many ticks!
>
> I had to set "CONFIG_IDE_TASK_IOCTL=y" in my .config in order to get
> it working.

How's that possible?
This config option only exports HDIO_DRIVE_TASKFILE ioctl to user-space.

--bart

