Return-Path: <linux-kernel-owner+w=401wt.eu-S1422690AbXAMPvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422690AbXAMPvk (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 10:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422699AbXAMPvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 10:51:40 -0500
Received: from smtp1.tech.numericable.fr ([82.216.111.37]:54757 "EHLO
	smtp1.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422690AbXAMPvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 10:51:39 -0500
From: Damien Wyart <damien.wyart@free.fr>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20-rc5: known unfixed regressions
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
	<20070113071125.GG7469@stusta.de>
Date: Sat, 13 Jan 2007 16:51:36 +0100
In-Reply-To: <20070113071125.GG7469@stusta.de> (Adrian Bunk's message of "Sat\,
	13 Jan 2007 08\:11\:25 +0100")
Message-ID: <87bql2ylfb.fsf@brouette.noos.fr>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk <bunk@stusta.de> [070113 08:11]:
> This still leaves the old regressions we have not yet fixed...
> This email lists some known regressions in 2.6.20-rc5 compared to 2.6.19.

> Subject    : BUG: scheduling while atomic: hald-addon-stor/...
>              cdrom_{open,release,ioctl} in trace
> References : http://lkml.org/lkml/2006/12/26/105
>              http://lkml.org/lkml/2006/12/29/22
>              http://lkml.org/lkml/2006/12/31/133
> Submitter  : Jon Smirl <jonsmirl@gmail.com>
>              Damien Wyart <damien.wyart@free.fr>
>              Aaron Sethman <androsyn@ratbox.org>
> Status     : unknown

I have not seen the problem since using rc3, so I guess it is ok now.
Maybe the commit 9414232fa0cc28e2f51b8c76d260f2748f7953fc has fixed the
problem, but I am not 100% sure.

-- 
Damien Wyart
