Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992541AbWJTHQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992541AbWJTHQu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992537AbWJTHQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:16:50 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:40376 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S2992539AbWJTHQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:16:49 -0400
Message-ID: <453877DB.4050704@qumranet.com>
Date: Fri, 20 Oct 2006 09:16:43 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com> <Pine.LNX.4.61.0610192212590.8142@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0610192212590.8142@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2006 07:16:48.0845 (UTC) FILETIME=[B5389FD0:01C6F417]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> +#ifndef __user
>> +#define __user
>> +#endif
>>     
>
> SHRUG. You should include <linux/compiler.h> instead of doing that. (And 
> on top, it may happen that compiler.h is automatically slurped in like 
> config.h, someone else could answer that)
>   

This is for userspace.  If there's a better solution I'll happily 
incorporate it.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

