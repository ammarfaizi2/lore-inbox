Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267286AbTBMI64>; Thu, 13 Feb 2003 03:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267726AbTBMI6z>; Thu, 13 Feb 2003 03:58:55 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:29113 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S267286AbTBMI6z>;
	Thu, 13 Feb 2003 03:58:55 -0500
Message-ID: <3E4B60A1.2060209@candelatech.com>
Date: Thu, 13 Feb 2003 01:08:49 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: select returning slow on RH 2.4.18-14 (RH 8.0) kernel.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been doing some testing with RH 8.0 on an Ezra 800Mhz
machine.

Even when lightly loaded select() often returns 3-9 miliseconds slower
than the timeout would suggest.  I know select is not guaranteed to
return with < 10ms accuracy, but with almost no load, shouldn't it
at least return with 1ms accuracy on average?

I don't remember having this problem on other machines and RH 7.3....

Anyone seen this problem?

Compiling a stock 2.4.20 kernel for the Ezra CPU now to see if that
helps anything...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


