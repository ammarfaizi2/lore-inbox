Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270678AbTGNSbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270692AbTGNSbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:31:46 -0400
Received: from sea2-f18.sea2.hotmail.com ([207.68.165.18]:3347 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270678AbTGNSbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:31:43 -0400
X-Originating-IP: [143.182.124.3]
X-Originating-Email: [dagriego@hotmail.com]
From: "David griego" <dagriego@hotmail.com>
To: alan@storlinksemi.com
Cc: linux-kernel@vger.kernel.org, dagriego@hotmail.com
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
Date: Mon, 14 Jul 2003 11:46:31 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F18ekWo76UaiRN00008964@hotmail.com>
X-OriginalArrivalTime: 14 Jul 2003 18:46:31.0798 (UTC) FILETIME=[3E28A160:01C34A38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IMHO, there are several cases for some type of TCP/IP offload.  One is for 
embedded systems that are just not capable of doing 1Gbps+.  Another is with 
10GbE, even high end servers will not be able keep up with TCP 
processing/data movement at these speeds.  Not being proactive in adopting 
TCP/IP offload will force Linux into accepting some scheme that will not 
necissarily be best.


>Alan Shih wrote:
>>Has anyone worked on a standard interface between TOE and Linux? (ie. 
>>something like Trapeze/Myrinet's GMS?)
>>
>>Or TOE is a forbidden discussion? Any effort in making Linux the OS for 
>>TOE at all even though Linux is a little too heavy for it?
>
>
>
>I do not forsee there _ever_ being a TOE interface for Linux.
>
>
>It's not a forbidden discussion, but, the networking developers tend to
>ignore people who mention TOE because it's been discussed to death, and
>no evidence has ever been presented to prove it has advantages where it
>matters, and it has significant _dis_advantages from the get-go.
>
>
>I really should write an LKML FAQ entry for TOE.
>
>
>        Jeff
>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at http://www.tux.org/lkml/
>

_________________________________________________________________
STOP MORE SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

