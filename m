Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271239AbTHHHHh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 03:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271262AbTHHHHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 03:07:37 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:2530 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S271239AbTHHHHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 03:07:32 -0400
Message-ID: <3F334C34.90403@comcast.net>
Date: Fri, 08 Aug 2003 03:07:32 -0400
From: Alexander Winston <alexander.winston@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jasper Spaans <jasper@vs19.net>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
References: <20030807180032.GA16957@spaans.vs19.net> <Pine.LNX.4.53.0308072139320.12875@montezuma.mastecende.com> <20030808065230.GA5996@spaans.vs19.net>
In-Reply-To: <20030808065230.GA5996@spaans.vs19.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jasper Spaans wrote:

>On Thu, Aug 07, 2003 at 09:42:37PM -0400, Zwane Mwaikambo wrote:
>
>  
>
>>>It changes all occurrences of 'flavour' to 'flavor' in the complete tree;
>>>I've just comiled all affected files (that is, the config resulting from
>>>make allyesconfig minus already broken stuff) succesfully on i386.
>>>      
>>>
>>Arrrgh! You can't be serious!
>>    
>>
>
>Yes, I am bloody serious; this patch might look purely cosmetic at first
>sight.. yet, there's a technical reason for at least one part of it. Grep
>and see the horror:
>
>$ egrep -ni 'flavou?r' fs/nfs/inode.c
>[snip]
>1357:	rpc_authflavor_t authflavour;
>[snip]
>
>VrGr,
>
I think another important issue is consistency. We should choose a 
style, and then stick with it.

