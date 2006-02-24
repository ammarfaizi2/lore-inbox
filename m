Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWBXLE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWBXLE4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 06:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWBXLE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 06:04:56 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:36060 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750808AbWBXLEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 06:04:55 -0500
Date: Fri, 24 Feb 2006 10:53:50 +0100
From: Holger Eitzenberger <holger@my-eitzenberger.de>
To: Florian Engelhardt <f.engelhardt@21torr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel assertion in net/ipv4/tcp.c
Message-ID: <20060224095350.GA5111@kruemel.my-eitzenberger.de>
Mail-Followup-To: Florian Engelhardt <f.engelhardt@21torr.com>,
	linux-kernel@vger.kernel.org
References: <20060123102805.6bd39bcc@HAL2000>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123102805.6bd39bcc@HAL2000>
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:8548cd0e00552bb75411ff34ad15700a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 10:28:05AM +0100, Florian Engelhardt wrote:

> Linux www 2.6.14-gentoo-r2 #4 SMP Mon Nov 28 10:35:23 CET 2005 i686
> Intel(R) Xeon(TM) CPU 3.20GHz GenuineIntel GNU/Linux
> 
> I have a Marvell Yukon Ethernet card inside.
> 
> And i have some trouble with it (see the attached log file).
> I get tons of error messages in my kern.log, all the same:
> Jan 15 11:11:20 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed
> at net/ipv4/tcp.c (1171)

Hi,

I see similar errors here on several boxes, all with Marvel chipsets and
sk98lin.  Do you use sk98lin or skge/sky2?

Thanks.  /holger


