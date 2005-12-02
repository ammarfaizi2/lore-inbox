Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbVLBUIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVLBUIV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 15:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVLBUIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 15:08:21 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:38876 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1750994AbVLBUIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 15:08:20 -0500
Message-ID: <4390A9B1.3040300@candelatech.com>
Date: Fri, 02 Dec 2005 12:08:17 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: netdev@vger.kernel.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] ip / ifconfig redesign
References: <200512022253.19029.a1426z@gawab.com>
In-Reply-To: <200512022253.19029.a1426z@gawab.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> The current ip / ifconfig configuration is arcane and inflexible.  The reason 
> being, that they are based on design principles inherited from the last 
> century.
> 
> In a GNU/OpenSource environment, OpenMinds should not inhibit themselves 
> achieving new design-goals to enable a flexible non-redundant configuration.
> 
> Specifically, '#> ip addr ' exhibits this issue clearly, by requiring to 
> associate the address to a link instead of the other way around.
> 
> Consider this new approach for better address management:
> 1. Allow the definition of an address pool
> 2. Relate links to addresses
> 3. Implement to make things backward-compatible.
> 
> The obvious benefit here, would be the transparent ability for apps to bind 
> to addresses, regardless of the link existence.
> 
> Another benefit includes the ability to scale the link level transparently, 
> regardless of the application bind state.

Can you do this with the current code by using scripts/whatever to move
virtual IPs around the interfaces?

I guess I don't really understand what you are proposing...

Ben

> 
> And there may be many other benefits... (i.e. 100% OSI compliance)
> 
> --
> Al
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

