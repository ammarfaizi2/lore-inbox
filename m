Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbUKGU3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbUKGU3C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 15:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbUKGU3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 15:29:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9390 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261655AbUKGU2v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 15:28:51 -0500
Date: Sun, 7 Nov 2004 15:11:52 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Thomas Oulevey <thomas.oulevey@elonex.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 lockup issue (flush_tlb_all)
Message-ID: <20041107171152.GA29846@logos.cnet>
References: <1099481807.4714.85.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099481807.4714.85.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 12:36:47PM +0100, Thomas Oulevey wrote:
> Hello,
> 
> We are experiencing some lockup problems with our SMP configuration. 
> Here are the details :
> - The computers lockup with no relevant logs.
> - The kernel still replies to ping but higher level services are not
> responding.
> - After few hours (5-8), the kernel answers again and the load is around
> 40 then decreasing. 
> 
> We manage to get some SysRq showPc output (screenshot :
> http://www.elonex.ch/shot/)
> According to the basic sysreq debugging, the problem seems to be related
> to the function flush_tlb_all, and it is triggered with a write or read
> (local or on nfs sometimes).
> 
> I looked at the LKML, and didn't find any known issues.
> Maybe it has been corrected but not backported by redhat ! 
> I'll appreciate any help.
> 
> Thank you in advance.
> 
> detailed configuration :
> ---------------
> Processor   : 2 x 2.8Ghz Pentium Xeon
> Motherboard : Intel se7501cw2
> Memory      : 4 x 512MB DDR 266 ECC registered
> Kernel      : 2.4.20-31 (Redhat 7.3 with updates)

You should report this one to the RH people, but I think RH 7.3 
isnt support anymore? 

Upgrading the kernel is a good idea.
