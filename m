Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUCJCqk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 21:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUCJCqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 21:46:40 -0500
Received: from fmr06.intel.com ([134.134.136.7]:14270 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261454AbUCJCqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 21:46:39 -0500
Message-ID: <404E8187.3090307@linux.co.intel.com>
Date: Tue, 09 Mar 2004 20:46:31 -0600
From: James Ketrenos <jketreno@linux.co.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dax Kelson <dax@gurulabs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Announce] Intel PRO/Wireless 2100 802.11b driver
References: <404E27E6.40200@linux.co.intel.com> <1078866774.2925.15.camel@mentor.gurulabs.com>
In-Reply-To: <1078866774.2925.15.camel@mentor.gurulabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dax Kelson wrote:

> Is it is really *firmware*, in that it loads and executes purely within
> the Intel PRO/Wireless 2100 itself and not in the linux kernel on the
> main CPU? If so, bravo!

Yes, it is really firmware.  It is loaded from disk as a block of data and 
passed to the card.  The system CPU doesn't execute anything out of the 
firmware, nor does the firmware know anything about the kernel.

> Does a similar effort exist for the upcoming Sonoma 802.11a/b/g
> component? Will Linux support be available for Sonoma at launch?

It is our intention to support a/b/g WLAN with a driver for Linux, but details 
are being worked out so we have no dates or commitment at this time.

Thanks,
James
