Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbSKKV5J>; Mon, 11 Nov 2002 16:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbSKKV5J>; Mon, 11 Nov 2002 16:57:09 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:3210 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S261451AbSKKV5H>;
	Mon, 11 Nov 2002 16:57:07 -0500
Message-ID: <3DD028F5.7080209@candelatech.com>
Date: Mon, 11 Nov 2002 14:02:29 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Folkert van Heusden <folkert@vanheusden.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: how to export a symbol so that I can use it in a module
References: <002c01c289cc$e6468470$3640a8c0@boemboem>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden wrote:
> Hi,
> 
> I've added a function "create_tcp_port_number" to net/core/utils.c
> like this:
> 
> int create_tcp_port_number(void)
> {
> /* blah blah */
> }
> EXPORT_SYMBOL(create_tcp_port_number);

Try putting the EXPORT_SYMBOL macro in net/netsyms.c

Ben


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


