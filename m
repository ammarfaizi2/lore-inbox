Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbTEUJ4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 05:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTEUJ4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 05:56:33 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:4900 "EHLO
	mwinf0501.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261843AbTEUJ4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 05:56:31 -0400
Message-ID: <3ECB5171.8030305@wanadoo.fr>
Date: Wed, 21 May 2003 12:14:09 +0200
From: FORT David <david.fort44@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030515
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Frank Victor Fischer <celestar@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with routing in the IPv6 stack
References: <1053469464.2637.10.camel@darkstar.fischer.homeip.net>
In-Reply-To: <1053469464.2637.10.camel@darkstar.fischer.homeip.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Victor Fischer wrote:

>Hello out there,
>
>I have encountered the following error message when trying to set up a
>new entry in the IPv6 routing table with the command "ip -6 route add":
>
>RTNETLINK answers: Cannot allocate memory
>
>This has happened after I have had a working IPv6 configuration for
>several days, and the error message is independent from the interface on
>which I am trying to establish the route on.
>
>No information at all has been recorded in the system logs by the
>kernel, however I have straced the command which did not reveal any
>useful information either. I backed up the results of the strace as well
>as the /proc/net/ and /proc/sys/net/ trees, along with the ifconfig.
>
>This occured the following platform:
>AMD Duron 800 with 256 MB 133 MHz SDR-SDRAM
>vanilla linux kernel 2.4.20 patches with XFS 1.2 and IPsec 1.98b.
>
>I am not subscribed to the list so it would be most helpful if you
>included me in the CC: list.
>
>Thanks in advance, 
>Victor (celestar@t-online.de)
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
I have the same message on my firewall with USAGI when the route to add 
already exists. This
is when changing routes associated with an ipv6 tunnel, but the error 
looks very related. This
may be system call that doesn't set properly errno, or ip which could be 
buggy.

My 2 euro cents.

-- 
%------ -- This was sent by Djinn running Linux 2.4.21-rc1 -- ------------%


