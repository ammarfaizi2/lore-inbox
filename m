Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVCJDtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVCJDtd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 22:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVCJDqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 22:46:54 -0500
Received: from fire.osdl.org ([65.172.181.4]:12163 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261281AbVCJDp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 22:45:56 -0500
Date: Wed, 9 Mar 2005 19:47:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Omkhar Arasaratnam <iamroot@ca.ibm.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, tgall@us.ibm.com,
       antonb@au1.ibm.com, James Bottomley <James.Bottomley@SteelEye.com>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [BUG] 2.6.11- sym53c8xx Broken on pp64
In-Reply-To: <422FC042.40303@ca.ibm.com>
Message-ID: <Pine.LNX.4.58.0503091944030.2530@ppc970.osdl.org>
References: <422FA817.4060400@ca.ibm.com> <1110420620.32525.145.camel@gaston>
 <422FBACF.90108@ca.ibm.com> <422FC042.40303@ca.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Mar 2005, Omkhar Arasaratnam wrote:
> 
> I confirmed that this occurs with the 2.6.11 code straight from 
> kernel.org Here is an error from the bringup:

So if 2.6.9 works, and 2.6.11 does not, can you check 2.6.10? And perhaps 
hunt it down even more, to a -rc release?

> sym0: No NVRAM, ID 7, Fast-80 LVD, parity checking
> CACHE TEST FAILED: DMA error (dstat=0xa0) .sym0: CACHE INCORRECTLY CONFIGURED
> sym0: giving up ...

There are certainly sym changes in there too since 2.6.9, let's see if 
James or Willy have any suggestions. It might not be ppc64-specific.

		Linus
