Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSKZWTP>; Tue, 26 Nov 2002 17:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSKZWTP>; Tue, 26 Nov 2002 17:19:15 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:3297 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S261339AbSKZWTO>;
	Tue, 26 Nov 2002 17:19:14 -0500
Message-ID: <3DE3F4F9.4090506@candelatech.com>
Date: Tue, 26 Nov 2002 14:26:01 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: Steven Dake <sdake@mvista.com>,
       "Joao Alberto M. dos Reis (listas de discucao)" <lista@vudu.ath.cx>,
       lista do kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PROPOSAL] Network Load Balance
References: <1038264237.3731.9.camel@goku> <3DE2AB46.70100@mvista.com> <20021126112648.A30916@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> Here is something we did at Novell many years back that worked very well for 
> load balancing across multiple adapters.  This implementation allowed up
> to four (4) adapters to function with load balancing.  To pull this off,
> you need to spoof at the MAC laer and alter the MAC addresses in the 
> header of received frames to spoof the IP stack above.  This method 
> requires **NO** changes to any protocol stacks above.

How is this different from the bonding driver(s) that are already
in the kernel?

Also, round-robin type of things seem to cause trouble by re-ordering
packets (as seen by the receiving machine).

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


