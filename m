Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUITC4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUITC4K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 22:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUITC4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 22:56:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53711 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265477AbUITC4H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 22:56:07 -0400
Message-ID: <414E46B7.70901@pobox.com>
Date: Sun, 19 Sep 2004 22:55:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Li Shaohua <shaohua.li@intel.com>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: hotplug e1000 failed after 32 times
References: <1095396793.10407.9.camel@sli10-desk.sh.intel.com>	 <20040916221406.1f3764e0.akpm@osdl.org>	 <1095411933.10407.29.camel@sli10-desk.sh.intel.com>	 <20040917161920.16d18333.akpm@osdl.org>  <414B7470.4000703@pobox.com> <1095641512.24333.8.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1095641512.24333.8.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Li Shaohua wrote:
> I'm not familiar with the NIC driver, but this problem really is
> annoying. The gurus, please consider a solution. It's not an uncommon
> case. I believe it's common in a big system with hotplug support. I can
> understand why the driver doesn't support more than 32 a card, but one
> card with 32 times hotplug failed is a little ugly.


There should be no problem at all with the driver supporting 32 NICs... 
  in fact if it cannot support at least 99 NICs, I would consider that a 
bug.

	Jeff


