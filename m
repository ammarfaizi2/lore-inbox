Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbTA2Qdz>; Wed, 29 Jan 2003 11:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266379AbTA2Qdz>; Wed, 29 Jan 2003 11:33:55 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:43120 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S266367AbTA2Qdz>; Wed, 29 Jan 2003 11:33:55 -0500
Subject: Re: [Pcihpd-discuss] Questions about CPCI Hot Swap driver.
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Stanley Wang <stanley.wang@linux.co.intel.com>
Cc: Scott Murray <scottm@somanetworks.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0301291550500.10354-100000@manticore.sh.intel.com>
References: <Pine.LNX.4.44.0301291550500.10354-100000@manticore.sh.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Jan 2003 00:44:52 -0800
Message-Id: <1043743493.10695.14.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-29 at 00:06, Stanley Wang wrote:
> Hi, Scott
> I have some questions about your CPCI Hot Swap driver.
> Would you mind helping me to clarify them ?
> 1. Why need we clear the EXT bit in the HS_CSR in "disable_slot()"?
> I think the EXT bit has not been set at this point.

Wouldn't the EXT bit be set if the operator flips the ejector, and is
waiting for the system to respond?

> 2. I wonder why we could not receive the #ENUM interrupt when we unpluged
> the board after disabling the corresponding slot("echo 0 > power")? It 
> seems that the cpci_led_on has some mysterious side effect, but I could 
> not find any hints in the spec.
> Could you help me?
> Thanks in advance.
> 
> Best Regards,
> -Stan
>

