Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWC2T3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWC2T3w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 14:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWC2T3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 14:29:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10469 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750767AbWC2T3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 14:29:52 -0500
Date: Wed, 29 Mar 2006 11:29:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: clem@clem.clem-digital.net, klassert@mathematik.tu-chemnitz.de,
       linux-kernel@vger.kernel.org
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
Message-Id: <20060329112931.766aecbd.akpm@osdl.org>
In-Reply-To: <200603291449.k2TEn7av001867@clem.clem-digital.net>
References: <20060328224904.4949daaf.akpm@osdl.org>
	<200603291449.k2TEn7av001867@clem.clem-digital.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Clements <clem@clem.clem-digital.net> wrote:
>
> Quoting Andrew Morton
>   > > Quoting Steffen Klassert
>   > >   > >   Had several of these with git11
>   > >   > >   NETDEV WATCHDOG: eth0: transmit timed out
>   > >   > 
>   > >   > Is this for sure that these messages occured first time with git11?
>   > >   > There were no changes in the 3c59x driver between git10 and git11.
>   > >   > 
>   > > Tried 2.6.15 and could not get a timed out condition.  Looks like
>   > > that defect is between 15 and 16 in my case.  
>   > > 
>   > > Be glad to do any testing that I can.
>   > > 
>   > 
>   > Please try adding the 3c59x module parameter `global_enable_wol=0', see if
>   > that helps.
>   > 
> Driver is compiled in, not module.
> 

Boot with 3c59x.global_enable_wol=0 on the kernel command line.
