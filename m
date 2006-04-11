Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWDKM2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWDKM2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 08:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWDKM2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 08:28:08 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:53397 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750801AbWDKM2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 08:28:07 -0400
Date: Tue, 11 Apr 2006 14:28:06 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 40% IDE performance regression going from FC3 to FC5 with same kernel
Message-ID: <20060411122806.GA26836@rhlx01.fht-esslingen.de>
References: <5a4c581d0604080747w61464d48k5480391d98b2bc47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c581d0604080747w61464d48k5480391d98b2bc47@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Apr 08, 2006 at 04:47:18PM +0200, Alessandro Suardi wrote:
> I'll be filing a FC5 performance bug for this but would like an opinion
>  from the IDE kernel people just in case this has already been seen...
> 
> I just upgraded my home K7-800, 512MB RAM box from FC3 to FC5
>  and noticed a disk performance slowdown while copying files around.

Just another suggestion: try eliminating/pinpointing I/O scheduler issues
(switch e.g. to "noop" at /sys/block/hda/queue/scheduler and compare again)

Andreas Mohr
~
