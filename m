Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268402AbRHAVyT>; Wed, 1 Aug 2001 17:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268398AbRHAVyJ>; Wed, 1 Aug 2001 17:54:09 -0400
Received: from zeus.kernel.org ([209.10.41.242]:57827 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S268362AbRHAVxt>;
	Wed, 1 Aug 2001 17:53:49 -0400
Date: Wed, 1 Aug 2001 16:52:24 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: joseph.bueno@trader.com
cc: Ben Greear <greearb@candelatech.com>,
        Chris Friesen <cfriesen@nortelnetworks.com>,
        Thomas Zehetbauer <thomasz@hostmaster.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tulip driver still broken
In-Reply-To: <3B683237.641478BE@trader.com>
Message-ID: <Pine.LNX.3.96.1010801165140.29413B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001 joseph.bueno@trader.com wrote:
> I am currently using a Xircom Ethernet adapter (tulip_cb module) with a
> 2.4.5 kernel.
> 
> The only way I have found to make it work is to turn on promiscuous mode
> (with 'tcpdump -i eth0 -n > /dev/null') after bootup. I can turn it off
> after a few minutes without problem. 

To fix this problem, either use the xircom_tulip_cb driver in 2.4.x, or
use the recently updated tulip_cb driver that comes with the pcmcia_cs
package.

