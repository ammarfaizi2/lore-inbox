Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270734AbTHFREG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270767AbTHFREG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:04:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:40131 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270734AbTHFRC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:02:56 -0400
Subject: Re: [RFC][PATCH] linux-2.6.0-test2_mtrr-race-fix_A0
From: Mark Haverkamp <markh@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matt <colpatch@us.ibm.com>, "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <1060136258.10738.31.camel@cog.beaverton.ibm.com>
References: <1060136258.10738.31.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1060189373.10672.7.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 06 Aug 2003 10:02:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-05 at 19:17, john stultz wrote:
> All, 


> 
> Amazingly this has been in the kernel for about a year, yet its not
> bothered me until very recently. Go figure. 

I started seeing this on an 8-way after the mtrr_init function was
changed from core_initcall to subsys_initcall.

> 
> Please review and comment on the following fix. Please let me know if
> I'm just wrong and the final flagging is more needed then I think. 

I applied this patch and so far I have been able to boot every time
without a hang on my 8-way.

Mark.


> 
> thanks
> -john

-- 
Mark Haverkamp <markh@osdl.org>

