Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTKUXAx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 18:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTKUXAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 18:00:52 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:6878 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261563AbTKUXAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 18:00:52 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: dick.streefland@xs4all.nl (Dick Streefland)
Subject: Re: IDE lockup after floppy access
Date: Sat, 22 Nov 2003 00:01:47 +0100
User-Agent: KMail/1.5.4
References: <2535.3fbe9484.4f0e6@altium.nl>
In-Reply-To: <2535.3fbe9484.4f0e6@altium.nl>
Cc: spam@streefland.xs4all.nl (Dick Streefland), linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311220001.47992.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does disabling CONFIG_PREEMPT cure the problem?

--bart

On Friday 21 of November 2003 23:41, Dick Streefland wrote:
> After accessing a floppy disk, the kernel blocks on the first harddisk
> access. After a couple of seconds, the following messages appear:
>
>   hda: dma_time_expiry: dma status = 0x61
>   hda: DMA timeout error
>
> I can only reset at this point. This is reproducible. I'm running
> kernel 2.6.0-test9 on an SMP system, but the problem doesn't go away
> when I boot with "nosmp". The kernel was built with CONFIG_PREEMPT.

