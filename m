Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbVIHAwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVIHAwi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 20:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbVIHAwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 20:52:38 -0400
Received: from mail.dvmed.net ([216.237.124.58]:29825 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932483AbVIHAwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 20:52:37 -0400
Message-ID: <431F8B46.8020209@pobox.com>
Date: Wed, 07 Sep 2005 20:52:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: netdev@axxeo.de, akpm@osdl.org, pavel@ucw.cz,
       ipw2100-admin@linux.intel.com, pavel@suse.cz,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [patch 1/1] ipw2100: remove by-hand function entry/exit debugging
References: <20050906.194111.130652562.davem@davemloft.net>	<431E5514.2070003@pobox.com>	<200509071539.08780.netdev@axxeo.de> <20050907.130151.71544363.davem@davemloft.net>
In-Reply-To: <20050907.130151.71544363.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Ingo Oeser <netdev@axxeo.de>
> Date: Wed, 7 Sep 2005 15:39:08 +0200
> 
> 
>>Jeff Garzik wrote:
>>
>>>I find them useful in my own drivers; they are definitely not pure noise.
>>
>>gcc -finstrument-functions
> 
> 
> I was going to mention this as well, and also the idea to
> enable CONFIG_MCOUNT on a per-file basis.
> 
> We should never be doing by hand what can be automated.


As long as nobody breaks the primary maintainer's primary method of 
debugging, patches are welcome...

	Jeff


