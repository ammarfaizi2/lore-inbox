Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVCGJQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVCGJQQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 04:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVCGJQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 04:16:16 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:48803 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261718AbVCGJQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 04:16:09 -0500
Message-ID: <422C1BD3.8080109@candelatech.com>
Date: Mon, 07 Mar 2005 01:16:03 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Leo Yuriev <leo@yuriev.ru>
CC: Patrick McHardy <kaber@trash.net>, linux-kernel@vger.kernel.org,
       Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH] ethernet-bridge: update skb->priority in case forwarded
 frame has VLAN-header
References: <1199527299.20050305165713@yuriev.ru> <422BABCE.3030904@candelatech.com> <856676954.20050307114350@yuriev.ru>
In-Reply-To: <856676954.20050307114350@yuriev.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leo Yuriev wrote:

> 3) But I think, it is not necessary to provide a customization of
> mapping .1q priority to skb->priority (e.g. clone a code from
> VLAN-module) for the following reasons:
>     - my patch is intended only for the basic, obvious behaviour;
>     - ebtables already provide a powerful abilities;
>     - user can expect that the bridge will not require more
>       configuration that currently is provided;

Thats fine by me.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

