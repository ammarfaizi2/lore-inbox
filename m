Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbTA3Apw>; Wed, 29 Jan 2003 19:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266962AbTA3Apw>; Wed, 29 Jan 2003 19:45:52 -0500
Received: from fmr01.intel.com ([192.55.52.18]:35557 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S266868AbTA3Apv>;
	Wed, 29 Jan 2003 19:45:51 -0500
Date: Thu, 30 Jan 2003 08:52:04 +0800 (CST)
From: Stanley Wang <stanley.wang@linux.co.intel.com>
X-X-Sender: stanley@manticore.sh.intel.com
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: Stanley Wang <stanley.wang@linux.co.intel.com>,
       Scott Murray <scottm@somanetworks.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [Pcihpd-discuss] Questions about CPCI Hot Swap driver.
In-Reply-To: <1043743493.10695.14.camel@vmhack>
Message-ID: <Pine.LNX.4.44.0301300846100.15010-100000@manticore.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jan 2003, Rusty Lynch wrote:

> On Wed, 2003-01-29 at 00:06, Stanley Wang wrote:
> > Hi, Scott
> > I have some questions about your CPCI Hot Swap driver.
> > Would you mind helping me to clarify them ?
> > 1. Why need we clear the EXT bit in the HS_CSR in "disable_slot()"?
> > I think the EXT bit has not been set at this point.
> 
> Wouldn't the EXT bit be set if the operator flips the ejector, and is
> waiting for the system to respond?
Thanks for your explanation.
I did not really know how to extract a board before reading your mail.
I always disable the slot (echo 0 > power) and yank the board, it is ok
to the damn zt5541 but not the proper way. 

Best Regards,
-Stan

-- 
Opinions expressed are those of the author and do not represent Intel
Corporation


