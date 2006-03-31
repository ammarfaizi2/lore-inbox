Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWCaOjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWCaOjO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 09:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWCaOjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 09:39:14 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:15373 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750754AbWCaOjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 09:39:14 -0500
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467305790AEB@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467305790AEB@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2DAA97AA-4DB6-4E2B-A702-729681BCA478@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: moving board support from arch/ppc/ to arch/powerpc
Date: Fri, 31 Mar 2006 08:39:20 -0600
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 31, 2006, at 4:44 AM, Zang Roy-r61911 wrote:

> Hi,
> 	I am moving mpc7448 hpc2 support from arch/ppc to arch/powerpc and  
> plan to summit it to open source tree future.  Is there any good  
> suggestion or reference?
> 	Thanks a lot!

All ports under arch/powerpc are required to use a flat device tree  
to boot.  Look at Documentation/powerpc/booting-without-of.txt
  for details on how that is done.  Beyond that there isn't too much  
different from arch/ppc to arch/powerpc.  Take a look at the 83xx or  
85xx platforms for comparison examples between arch/ppc & arch/powerpc.

I'd suggest for working up your flat dev tree for the bridge on HPC2  
and post that to the linuxppc-dev list for review and then go from  
there.

- kumar
