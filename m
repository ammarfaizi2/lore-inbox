Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVKCJk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVKCJk7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 04:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVKCJk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 04:40:59 -0500
Received: from penta.pentaserver.com ([66.45.247.194]:64656 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S932233AbVKCJk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 04:40:58 -0500
Message-ID: <4369D7D0.4070407@linuxtv.org>
Date: Thu, 03 Nov 2005 13:26:40 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Michael Krufky <mkrufky@m1k.net>, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org, Manu Abraham <manu@linuxtv.org>
Subject: Re: [PATCH 24/37] dvb: dst: protect the read/write commands with
 a mutex
References: <4367240C.8030204@m1k.net> <20051103135735.6d860a73.akpm@osdl.org>
In-Reply-To: <20051103135735.6d860a73.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: manu@kromtek.com
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Michael Krufky <mkrufky@m1k.net> wrote:
>  
>
>>+	sema_init(&state->dst_mutex, 1);
>>    
>>
>
>We normally use init_MUTEX(), so we don't have to remember that 1 == unlocked.
>
>  
>
Hello Andrew,

I will have that changed in dvb-kernel CVS. Would you like me to send in 
a patch for the same. Or you can have it changed .. ?


Thanks,
Manu

