Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSGERRz>; Fri, 5 Jul 2002 13:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317512AbSGERRy>; Fri, 5 Jul 2002 13:17:54 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:39059 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S317506AbSGERRx>;
	Fri, 5 Jul 2002 13:17:53 -0400
Message-ID: <3D25D550.6060109@candelatech.com>
Date: Fri, 05 Jul 2002 10:20:16 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Question concerning ifconfig
References: <180577A42806D61189D30008C7E632E8793972@boca213a.boca.ssc.siemens.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bloch, Jack wrote:
> I am running a Red Hat 7.2 load (Kernel version 2.4.7-10). I am trying to
> enter the following command to change the MAC address on my device.
> 
> ifconfig ifp0 hw ether A2:A5:A5:01:00:00
> 
> ifp0 is my own device which replaces eth0. The system gives me a response
> "SIOCSIFHWADDR : device or resources busy"
> The same exact command works on my 2.2.16 Kernel. Any ideas why the error.
> Please CC me directly in any responses.

ifconfig ifp0 down

first, then it should work.

Ben

> 
> Thanks in advance,  
> 
> Jack Bloch
> Siemens Carrier Networks
> e-mail    : jack.bloch@icn.siemens.com
> phone     : (561) 923-6550
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


