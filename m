Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSKRH2Q>; Mon, 18 Nov 2002 02:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbSKRH2Q>; Mon, 18 Nov 2002 02:28:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49163 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261582AbSKRH2P>;
	Mon, 18 Nov 2002 02:28:15 -0500
Message-ID: <3DD89813.9050608@pobox.com>
Date: Mon, 18 Nov 2002 02:34:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vergoz Michael <mvergoz@sysdoor.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 8139too.c patch for kernel 2.4.19
References: <028901c28ead$10dfbd20$76405b51@romain>
In-Reply-To: <028901c28ead$10dfbd20$76405b51@romain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vergoz Michael wrote:

> Hi list,
>
> The current 8139too.c linux kernel driver dosn't work.


Please be more specific.

> There is the patch for the driver 8139too.c at :
>
> http://descript.sysdoor.net/patch/kernel/2.4.19/8139too.c.diff
>
> It fix some problems with card mode, new hard detection and new card
> added.
>
> Please read the diff.



The diff is huge, mostly unnecessary, and backs out obvious bug fixes 
(i.e. it _adds_ bugs).  It removes several PCI IDs, eliminating 8139 
support for some cards.  The "new card" is supported by another driver, 
8139cp.c.

Please send _specific_ changes and bug fixes.

	Jeff



