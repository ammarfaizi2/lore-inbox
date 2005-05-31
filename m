Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVEaS77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVEaS77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 14:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVEaS77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 14:59:59 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:47627 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261186AbVEaS7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 14:59:50 -0400
Date: Tue, 31 May 2005 20:54:03 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Anil kumar <anils_r@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: suse 9.3pro x86_64 kernel source rpm fixdep script error
Message-ID: <20050531185403.GL18600@alpha.home.local>
References: <20050531184704.44932.qmail@web32411.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050531184704.44932.qmail@web32411.mail.mud.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, May 31, 2005 at 11:47:04AM -0700, Anil kumar wrote:
> Hi,
> 
> I downloaded SuSE 9.3pro x86_64 kernel-source rpm
> from:
> http://mirror.tv2.dk/pub/linux/suse/people/mantel/kotd/9.3-x86_64/SL93_BRANCH/
> 
> After extracting the rpm, the scripts under:
> /usr/src/linux-2.6.11.4-SL93_BRANCH_20050525084504-obj/x86_64/default/scripts/basic
> 
> The script "fixdep" reports error as:
> bash: ./fixdep: cannot execute binary file
> 
> #ll fixdep
> -rwxr-xr-x 2 root root 9120 May 31 09:25 fixdep
> 
> Looks like I have right execute permissions. Is it
> something I am missing/overlooked? Or the script is
> bad?

wrong arch or wrong interpreter (first line, after #!)

> FYI, I did rpm2cpio to extract it.
> 
> Thanks for help in advance.
> 
> with regards,
>   Anil

willy

