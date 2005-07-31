Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVGaLqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVGaLqD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 07:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbVGaLqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 07:46:02 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:49350 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261740AbVGaLqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 07:46:00 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc4-mm1
Date: Sun, 31 Jul 2005 13:51:05 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20050731020552.72623ad4.akpm@osdl.org>
In-Reply-To: <20050731020552.72623ad4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507311351.05641.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 31 of July 2005 11:05, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc4/2.6.13-rc4-mm1/
> 
> 
> - Dropped areca-raid-linux-scsi-driver.patch and iteraid.patch.  People who
>   need these can get them from 2.6.13-rc3-mm3.
> 
> - Dropped the CKRM patches.  I don't think they were doing much in -mm and
>   we didn't find many problems with them anyway.
> 
> - Dropped the connector patches: turns out that we no longer have a netlink
>   slot available for them anyway.

It looks like 2.6.13-rc4-mm1 is fine and dandy on two of AMD64 boxes I have
access to.  In particular, all of the problems that I've had recently with Asus L5D
seem to be gone now. :-))

I only had a problem with this kernel on a NUMA-enabled dual-Opteron box,
which hanged solid when I started to copy huge amounts of data from it over
the network.  If I'm able to reproduce it, I'll investigate it a bit more and let you
know.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
