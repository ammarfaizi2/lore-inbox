Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266023AbUGOMr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266023AbUGOMr4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 08:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUGOMr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 08:47:56 -0400
Received: from cantor.suse.de ([195.135.220.2]:20387 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266023AbUGOMrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 08:47:55 -0400
Date: Thu, 15 Jul 2004 14:47:50 +0200
From: Stefan Seyfried <seife@gmane0305.slipkontur.de>
To: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: swsuspend not working
Message-ID: <20040715124750.GA8065@suse.de>
References: <20040715121042.GB9873@lps.ens.fr.suse.lists.linux.kernel>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040715121042.GB9873@lps.ens.fr>
X-Operating-System: SUSE LINUX Enterprise Server 9 (i586), Kernel 2.6.5-7.97-default
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 12:13:10PM +0000, Éric Brunet wrote:

> I booted with " root=/dev/hda2 resume=/dev/hda5 init=/bin/sh". No initrd,
> of course. Once I had a prompt, I mounted /proc and echoed 4 to
> /proc/acpi/sleep. The screen blinked and 3 seconds later I was back at my

you have to swapon your swap partition.

> Here are the kernel messages I got:
> -----------------------------------------
> dsmthdat-0462 [36] ds_method_data_get_val: Uninitialized Local[0] at node df72f10c
> Freeing memory: .....|
> PM: Attempting to suspend to disk.
> PM: snapshotting memory.

that's not swsusp, that's pmdisk. check your kernel config.
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding thems out."
