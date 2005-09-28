Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbVI1Vh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbVI1Vh4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVI1Vh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:37:56 -0400
Received: from web34102.mail.mud.yahoo.com ([66.163.178.100]:49518 "HELO
	web34102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750974AbVI1Vh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:37:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=loy0cTOjsupoUjMN6w1xn+PLN2eNYwe4a4pL0kAjI1Z8r8aSdHknjcex0qxYu06+35Swg/v3hfMF7JICP2kPVRvY2meS/2qciC6d49zByKf4N8m7b6PB3GgVLkLu8PGVcuSLvlRft10/ApAs8/XeJC/1VGi+Tq2g+eLP5ABQBRk=  ;
Message-ID: <20050928213755.11544.qmail@web34102.mail.mud.yahoo.com>
Date: Wed, 28 Sep 2005 14:37:45 -0700 (PDT)
From: Wilson Li <yongshenglee@yahoo.com>
Subject: Re: Slow loading big kernel module in 2.6 on PPC platform
To: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <433B032E.8090900@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Bill Davidsen <davidsen@tmr.com> wrote:

> Wilson Li wrote:
> > Hi,
> > 
> > I am trying to port several third party kernel modules from
> kernel
> > 2.4 to 2.6 on a ppc (MPC824x) platform. For small size of
> modules, it
> > works perfectly in 2.6. But there's one huge kernel module which
> size
> > is about 2.7M bytes (size reported by lsmod after insmod), and it
> > takes about 90 seconds to load this module before init_module
> starts.
> > I did not notice there's such obvious delay in 2.4 kernel.
> 
> How big is the module on disk? That is, what is the disk to memory 
> transfer size. Really 2.7MB, or is there a lot of uninitialized
> storage?
> -- 
>     -bill davidsen (davidsen@tmr.com)

The original module size on disk is around 3.3M bytes. Here's details
of size.

   text    data     bss     dec     hex filename
2025644  263244  213024 2501912  262d18 mrbig.ko

Thanks,
Wilson Li


	
		
______________________________________________________ 
Yahoo! for Good 
Donate to the Hurricane Katrina relief effort. 
http://store.yahoo.com/redcross-donate3/ 

