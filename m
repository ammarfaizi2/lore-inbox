Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbUCKHs2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 02:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbUCKHs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 02:48:28 -0500
Received: from fmr05.intel.com ([134.134.136.6]:42980 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262819AbUCKHsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 02:48:23 -0500
Message-ID: <405019C2.5060409@linux.co.intel.com>
Date: Thu, 11 Mar 2004 01:48:18 -0600
From: James Ketrenos <jketreno@linux.co.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan De Luyck <lkml@kcore.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Announce] Intel PRO/Wireless 2100 802.11b driver
References: <404E27E6.40200@linux.co.intel.com> <200403100852.35429.lkml@kcore.org> <200403110723.47400.lkml@kcore.org>
In-Reply-To: <200403110723.47400.lkml@kcore.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan De Luyck wrote:
>>I can't test the actual transmitting since I've got no accesspoint handy.
>>Will do so when at home, though.
> 
> Tested this. It works, _if_ you set the AP address first, otherwise it bails 
> out with 'Fatal interrupt'.

So you're doing something like:

# modprobe ipw2100
# iwconfig eth1 ap 00:0d:88:28:2e:91
# ifconfig eth1 up

and if you skip the iwconfig step you see the fatal interrupt?

Btw, thanks for your prior post with the oops info.  There is a fix in the 
latest snapshot (0.30) on http://ipw2100.sf.net.

Thanks,
James
