Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262169AbSJARbO>; Tue, 1 Oct 2002 13:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262170AbSJARbN>; Tue, 1 Oct 2002 13:31:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45069 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262169AbSJARbG>;
	Tue, 1 Oct 2002 13:31:06 -0400
Message-ID: <3D99DD01.9070508@pobox.com>
Date: Tue, 01 Oct 2002 13:36:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kent Yoder <key@austin.ibm.com>
CC: linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de
Subject: Re: [PATCH] pcnet32 cable status check
References: <Pine.LNX.4.44.0210011222520.14661-100000@ennui.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kent Yoder wrote:
> Thus Spake Jeff Garzik:
> 
>>Looks good ;-)
> 
> 
>  Thanks,
> 
> 
>>One small thing -- since you appear to test all cases for (lp->mii) 
>>before calling mod_timer, I don't think you need to test lp->mii inside 
>>the timer...
> 
> 
>   Well, the reason I left that in there was so that another person could add 
> functionality to the watchdog if they wanted on a non-mii enabled card 
> without having to know that the check would need to be added. If that's not 
> that big a deal, I can remove it...


That's a fair enough argument, patch applied.


