Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946101AbWJSOvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946101AbWJSOvb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161442AbWJSOvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:51:31 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:16566 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1161437AbWJSOv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:51:29 -0400
Message-ID: <453790EC.8080008@qumranet.com>
Date: Thu, 19 Oct 2006 16:51:24 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: John Stoffel <john@stoffel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com>	 <17719.35854.477605.398170@smtp.charter.net> <1161269405.17335.80.camel@localhost.localdomain>
In-Reply-To: <1161269405.17335.80.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2006 14:51:29.0013 (UTC) FILETIME=[0F0E2A50:01C6F38E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-10-19 am 10:30 -0400, ysgrifennodd John Stoffel:
>   
>> Yuck.  ioclts are deprecated, you should be using /sysfs instead for
>> stuff like this, or configfs.  
>>     
>
>
> Making sure the ioctl sizes are the same in 32/64bit and aligned the
> same way is the more important issue.
>   

Yes, pointers are padded and all other types are explicitly sized.  
Alignment is always natural.

-- 
error compiling committee.c: too many arguments to function

