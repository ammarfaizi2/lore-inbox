Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287408AbSASVVp>; Sat, 19 Jan 2002 16:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287417AbSASVVg>; Sat, 19 Jan 2002 16:21:36 -0500
Received: from ppp-134-44.28-151.libero.it ([151.28.44.134]:15364 "HELO
	gateway.milesteg.arr") by vger.kernel.org with SMTP
	id <S287408AbSASVVR>; Sat, 19 Jan 2002 16:21:17 -0500
Date: Sat, 19 Jan 2002 22:21:09 +0100
From: Daniele Venzano <venza@iol.it>
To: Andy Pfiffer <andyp@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AGP update for i820 and i860 chipsets
Message-ID: <20020119212109.GA966@renditai.milesteg.arr>
In-Reply-To: <20020118221153.GA1263@renditai.milesteg.arr> <1011400424.954.0.camel@andyp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1011400424.954.0.camel@andyp>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 04:33:41PM -0800, Andy Pfiffer wrote:
> This patch works on my system.  You might want to take the extra step
> and fix the PCI device id list, too:
> % lspci | grep Unknown
> 00:00.0 Host bridge: Intel Corporation: Unknown device 2531 (rev 04)
> 00:02.0 PCI bridge: Intel Corporation: Unknown device 2533 (rev 04)
> % 

I looked in drivers/pci/devlist.h and found:

DEVICE(8086,2531,"82850 860 (Wombat) Chipset Host Bridge (MCH)")
DEVICE(8086,2533,"82860 860 (Wombat) Chipset AGP Bridge")

I hadn't to modify it.
This in kernel 2.4.17, I hope this is the only place where pci ids
reside, if not what shuold I change ?

-- 
-----------------------------------------------------
Daniele Venzano
Senior member of the Linux User Group Genova (LUGGe)
E-Mail: venza@iol.it
Web: http://digilander.iol.it/webvenza/
LUGGe: http://lugge.ziobudda.net

