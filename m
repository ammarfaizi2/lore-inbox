Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266430AbTGJTti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 15:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266434AbTGJTti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 15:49:38 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:29928 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266430AbTGJTth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 15:49:37 -0400
Date: Thu, 10 Jul 2003 22:04:02 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Steven Dake <sdake@mvista.com>
cc: <linux-kernel@vger.kernel.org>, <andre@linux-ide.org>,
       <frankt@promise.com>
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21, patch
 attached to fix
In-Reply-To: <3F0DC337.50903@mvista.com>
Message-ID: <Pine.SOL.4.30.0307102202340.22284-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Do you have "Special FastTrak Feature" enabled?

--
Bartlomiej

On Thu, 10 Jul 2003, Steven Dake wrote:

> Folks,
>
> After I upgraded to 2.4.21, I noticed my Gigabyte motherboard with
> onboard IDE Promise 20276 FastTrack RAID no longer works.  The following
> patch fixes the problem, which appears to be an incomplete list of
> devices in the ide setup code.  There are probably other fasttrack RAID
> adaptors that should be added to the setup code, but I don't know what
> they are.
>
> Thanks
> -steve

