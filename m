Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265545AbUEZMTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265545AbUEZMTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265529AbUEZMRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:17:20 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:17343 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265537AbUEZMRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:17:02 -0400
Date: Wed, 26 May 2004 21:17:03 +0900
From: AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com>
Subject: Re: [PATCH] NMI trigger switch support for debugging
In-reply-to: <20040525193721.7c71f61d.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <40B48ABF.80604@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.6 (X11/20040516)
References: <40B1BEAC.30500@jp.fujitsu.com>
 <20040524023453.7cf5ebc2.akpm@osdl.org> <40B3F484.4030405@jp.fujitsu.com>
 <20040525184148.613b3d6e.akpm@osdl.org> <40B400D1.1080602@jp.fujitsu.com>
 <20040525193721.7c71f61d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Andrew Morton wrote:

>AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com> wrote:
>  
>
>>Sorry, I resend document and patch.
>>    
>>
>
>Great, thanks.  Updates to Documentation/kernel-parameters.txt and
>Documentation/filesystems/proc.txt would be nice.
>
>
>If the machine locks up with interrupts enabled we can use sysrq-T and
>sysrq-P.  If it locks up with interrupts disabled the NMI watchdog will
>automatically produce the same info as your patch.  So what advantage does
>the patch add?
>  
>

People who think performance is very important and want to run only program
they need tend not to use NMI watchdog.
My patch does not affect performance at all, and it just run when NMI switch
is pressed. Whenever debugging information is needed, we can always get it.

Regards,
Nobuyuki Akiyama


