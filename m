Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131171AbRCQWDG>; Sat, 17 Mar 2001 17:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131184AbRCQWC4>; Sat, 17 Mar 2001 17:02:56 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:30475 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131171AbRCQWCv>; Sat, 17 Mar 2001 17:02:51 -0500
Date: Sat, 17 Mar 2001 22:02:06 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Andy Chou <acc@CS.Stanford.EDU>
cc: <linux-kernel@vger.kernel.org>, <mc@CS.Stanford.EDU>
Subject: Re: [CHECKER] 16 potential locking bugs in 2.4.1
In-Reply-To: <20010316213444.A3592@Xenon.Stanford.EDU>
Message-ID: <Pine.LNX.4.30.0103172159310.17004-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2001, Andy Chou wrote:

> Here are some more results from the MC project.  These are 16 errors found
> in 2.4.1 related to inconsistent use of locks. 

> +---------------------------------+----------------------------+
> | file                            | fn                         |
> +---------------------------------+----------------------------+
> | drivers/mtd/cfi_cmdset_0001.c   | cfi_intelext_suspend       |
> | drivers/mtd/cfi_cmdset_0002.c   | cfi_amdext_suspend         |

Fixed in CVS some time ago. Will be flushed to Linus some time in the near
future, after I've cleaned up the inter_module_xxx abomination.

-- 
dwmw2


