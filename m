Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423502AbWJaPxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423502AbWJaPxu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423493AbWJaPxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:53:50 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:4320 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1422840AbWJaPxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:53:49 -0500
Message-ID: <454771D8.9080307@candelatech.com>
Date: Tue, 31 Oct 2006 07:55:04 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: peter.hicks@poggs.co.uk, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Thousands of interfaces
References: <20061031092550.GA8201@tufnell.london.poggs.net> <20061031.013154.122620846.davem@davemloft.net>
In-Reply-To: <20061031.013154.122620846.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> From: Peter Hicks <peter.hicks@poggs.co.uk>
> Date: Tue, 31 Oct 2006 09:25:50 +0000
>
> [ Discussion belongs on netdev@vger.kernel.org, added to CC: ]
>
>   
>> I have a dual 3GHz Xeon machine with a 2.4.21 kernel and thousands (15k+) of
>> ipip tunnel interfaces.  These are being used to tunnel traffic from remote
>> routers, over a private network, and handed off to a third party.
>>     
>  ...
>   
>> Is it possible to speed up creation of the interfaces?  Currently it takes
>> around 24 hours.  Is there are more efficient way to handle a very large
>> number of IP-IP tunnels?  Would upgrading to a 2.6 kernel be of use?
>>     
>
>   
2.6 (and the associated 'ip' tool) does have some improvements for 
showing very
large numbers of interfaces.  I haven't tried more than a few thousand 
though...

Ben


-- 
Ben Greear <greearb@candelatech.com> 
Candela Technologies Inc  http://www.candelatech.com


