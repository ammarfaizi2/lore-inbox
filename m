Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUHDQxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUHDQxv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 12:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUHDQxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 12:53:51 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:4749 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S266274AbUHDQxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 12:53:49 -0400
Message-ID: <411114E6.2060407@myrealbox.com>
Date: Wed, 04 Aug 2004 09:55:02 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Realtek 8169 NIC driver version
References: <1677288031.20040803142517@yahoo.com.cn> <20040803093606.A4911@electric-eye.fr.zoreil.com>
In-Reply-To: <20040803093606.A4911@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> dlion <dlion2005@yahoo.com.cn> :
> [...]
> 
>>  I have read some driver codes in the Linux kernel. I noticed
>>that the RTL-8169 driver(r8169.c) is an older version (v1.2).
>>There is a newer drivers on Realtek's website. It's version
>>number is v1.6 , and it is really much better than v1.2. Why
>>not merge it into official kernel realease?
> 
> 
> It has already been merged in 2.4.x and 2.6.x. That's old history,
> really.

This one bit me awhile back, too.  Could we just remove that version 
number?  (Especially with the latest round of changes, the in-kernel 
driver bears little resemblance to Realtek's.)

--Andy
