Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263054AbVCJUgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263054AbVCJUgb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 15:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263048AbVCJUcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 15:32:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2727 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S263091AbVCJU3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 15:29:41 -0500
Message-ID: <4230AE24.602@pobox.com>
Date: Thu, 10 Mar 2005 15:29:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Netdev <netdev@oss.sgi.com>, stable@kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Roger Luethi <rl@hellgate.ch>
Subject: Re: [stable] [BK PATCHES] 2.6.x net driver oops fixes
References: <422F59E8.2090707@pobox.com> <20050310202548.GV5389@shell0.pdx.osdl.net>
In-Reply-To: <20050310202548.GV5389@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Jeff Garzik (jgarzik@pobox.com) wrote:
> 
> 
>>This will update the following files:
>>
>> drivers/net/sis900.c    |   41 +++++++++++++++++++++--------------------
>> drivers/net/via-rhine.c |    3 +++
> 
> 
> The via-rhine fix is already in the stable queue.  But the sis900 oops
> fix does not apply to the stable tree.  It relies on a few intermediate
> patches.  Appears to still be an issue for the older version which is in
> 2.6.11.  Here's a stab at a backport.  Would you like to review/validate
> or drop this one?

The backport looks correct to me, though it would be nice to get a 
via-rhine owner to ACK the patch before it goes in...

	Jeff


