Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbVKWXf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVKWXf5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVKWXf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:35:57 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:10881 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751317AbVKWXfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:35:55 -0500
References: <200511232333.jANNX9g23967@unix-os.sc.intel.com>
Message-ID: <cone.1132788946.360368.25446.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: =?ISO-8859-1?B?Q2hlbiw=?= Kenneth W <kenneth.w.chen@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at mm/rmap.c:491
Date: Thu, 24 Nov 2005 10:35:46 +1100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W writes:

> Con Kolivas wrote on Wednesday, November 23, 2005 3:24 PM
>> Chen, Kenneth W writes:
>> 
>> > Has people seen this BUG_ON before?  On 2.6.15-rc2, x86-64.
>> > 
>> > Pid: 16500, comm: cc1 Tainted: G    B 2.6.15-rc2 #3
>> > 
>> > Pid: 16651, comm: sh Tainted: G    B 2.6.15-rc2 #3
>> 
>>                        ^^^^^^^^^^
>> 
>> Please try to reproduce it without proprietary binary modules linked in.
> 
> 
> ???, I'm not using any modules at all.
> 
> [albat]$ /sbin/lsmod
> Module                  Size  Used by
> [albat]$ 
> 
> 
> Also, isn't it 'P' indicate proprietary module, not 'G'?
> line 159: kernel/panic.c:
> 
>         snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c",
>                 tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',

Sorry it's not proprietary module indeed. But what is tainting it?

Con

