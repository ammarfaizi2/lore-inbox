Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVCHBbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVCHBbn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 20:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVCHBba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 20:31:30 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:33445 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S262024AbVCHB3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 20:29:40 -0500
Message-ID: <422CFFFF.2010501@candelatech.com>
Date: Mon, 07 Mar 2005 17:29:35 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Josef E. Galea" <josefeg@euroweb.net.mt>
CC: Scott Feldman <sfeldma@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Sending IP datagrams
References: <422CE853.8070603@euroweb.net.mt> <9b84705fe7666dfbbf1782ca85ae2ae0@pobox.com> <422CF779.6030508@euroweb.net.mt>
In-Reply-To: <422CF779.6030508@euroweb.net.mt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef E. Galea wrote:
> Scott Feldman wrote:
> 
>>
>> On Mar 7, 2005, at 3:48 PM, Josef E. Galea wrote:
>>
>>> Hi,
>>>
>>> Is there any way, other than socket buffers, to send IP datagrams 
>>> from a kernel module? If yes, can you please point me to some good 
>>> tutorial or sample code
>>
>>
>>
>> See net/core/pktgen.c for an example.
>>
>> -scott
>>
> AFAIK that module uses socket buffers (struct sk_buff) to send the 
> packets. I was asking whether there was another way to send the IP 
> datagrams.

The sk_buf is the thing you send to network drivers, it doesn't get
any more basic unless you are hacking a particular driver and DMA'ing memory
or something like that...

Maybe you should explain what you are really trying to do?

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

