Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUI0Pcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUI0Pcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUI0Pcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:32:41 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:41363 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S266481AbUI0Pc1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:32:27 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproductions.com
To: gene.heskett@verizon.net
Subject: Re: 2.6.9-rc2-mm4
Date: Mon, 27 Sep 2004 08:32:25 -0700
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409270053.22911.gene.heskett@verizon.net>
In-Reply-To: <200409270053.22911.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409270832.26451.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm the same problem here for 2.6.9-rc2-mm4. Right after the ' 
Checking 'hlt' instruction .. OK ' it hangs.

On Sunday 26 September 2004 9:53 pm, Gene Heskett wrote:
> On Sunday 26 September 2004 21:10, Andrew Morton wrote:
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-
> >rc2/2.6.9-rc2-mm4/
> >
> >- ppc64 builds are busted due to breakage in bk-pci.patch
> >
> >- sparc64 builds are busted too.  Also due to pci problems.
> >
> >- Various updates to various things.  In particular, a kswapd
> > artifact which could cause too much swapout was fixed.
> >
> >- I shall be offline for most of this week.
>
> The bootup hangs, from dmesg after reboot to 2.6.9-rc2-mm3:
>
> Checking 'hlt' instruction... OK.
> -----
> 2.6.9-rc2-mm4 hangs here, and never gets to the next line
> -----
> NET: Registered protocol family 16
>
> So I assume something in the next line hangs it. Sysrq-t has no
> repsonse, must use the hardware reset button.
>
> Ideas?
