Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269057AbTCAWey>; Sat, 1 Mar 2003 17:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269060AbTCAWey>; Sat, 1 Mar 2003 17:34:54 -0500
Received: from dhcp93-dsl-usw3.w-link.net ([206.129.84.93]:40144 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S269057AbTCAWex>;
	Sat, 1 Mar 2003 17:34:53 -0500
Message-ID: <3E6137EC.4010202@candelatech.com>
Date: Sat, 01 Mar 2003 14:45:00 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew McGregor <andrew@indranet.co.nz>
CC: Stephen Corey <s_corey@netzero.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel tuning for high latency satellite link??
References: <000001c2e00b$71bb7d50$0301a8c0@corey> <132088132.1046604929@[192.168.0.1]>
In-Reply-To: <132088132.1046604929@[192.168.0.1]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew McGregor wrote:
> It should do OK by default, but you might want to read RFC 3150 for some 
> ideas for things to do to help.
> 
> Andrew

Testing I have done shows it will probably NOT be ok by default, especially
if you have any significant bandwidth on your satellite link.  I would suggest
increasing the tcp_[rw]mem buffers at least.

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


