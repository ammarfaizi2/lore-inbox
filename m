Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVDNCKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVDNCKn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 22:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVDNCKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 22:10:42 -0400
Received: from mail.avantwave.com ([210.17.210.210]:11957 "EHLO
	mail.avantwave.com") by vger.kernel.org with ESMTP id S261413AbVDNCKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 22:10:38 -0400
Message-ID: <425DD105.7010304@haha.com>
Date: Thu, 14 Apr 2005 10:10:13 +0800
From: Tomko <tomko@haha.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Catalin Marinas <catalin.marinas@arm.com>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Why system call need to copy the date from the userspace before
 using it
References: <425C9E55.6010607@haha.com> <20050413102916.GS4965@lug-owl.de>	<425CF7DB.4000407@haha.com> <tnxd5szvsnd.fsf@arm.com>
In-Reply-To: <tnxd5szvsnd.fsf@arm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin Marinas wrote:

>Tomko <tomko@haha.com> wrote:
>  
>
>>Inside the system call , the kernel often copy the data by calling
>>copy_from_user() rather than just using strcpy(), is it because the
>>memory mapping in kenel space is different from user space?
>>    
>>
>
>No, it is because this function checks whether the access to the user
>space address is OK. There are situations when it can also sleep (page
>not present).
>
>  
>
what u means "OK"?  kernel space should have right to access any memory 
address , can u expained in details what u means "OK"?
