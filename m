Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWC2GtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWC2GtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 01:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWC2GtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 01:49:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28356 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751102AbWC2GtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 01:49:17 -0500
Date: Tue, 28 Mar 2006 22:49:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: klassert@mathematik.tu-chemnitz.de, clem@clem.clem-digital.net,
       linux-kernel@vger.kernel.org
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
Message-Id: <20060328224904.4949daaf.akpm@osdl.org>
In-Reply-To: <200603290250.k2T2od8d001585@clem.clem-digital.net>
References: <20060328141443.GB8455@gareth.mathematik.tu-chemnitz.de>
	<200603290250.k2T2od8d001585@clem.clem-digital.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Clements <clem@clem.clem-digital.net> wrote:
>
> Quoting Steffen Klassert
>   > >   Had several of these with git11
>   > >   NETDEV WATCHDOG: eth0: transmit timed out
>   > 
>   > Is this for sure that these messages occured first time with git11?
>   > There were no changes in the 3c59x driver between git10 and git11.
>   > 
> Tried 2.6.15 and could not get a timed out condition.  Looks like
> that defect is between 15 and 16 in my case.  
> 
> Be glad to do any testing that I can.
> 

Please try adding the 3c59x module parameter `global_enable_wol=0', see if
that helps.

