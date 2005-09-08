Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbVIHMHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVIHMHy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 08:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVIHMHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 08:07:53 -0400
Received: from mail1.bizmail.net.au ([202.162.77.164]:25538 "EHLO
	mail1.bizmail.net.au") by vger.kernel.org with ESMTP
	id S932473AbVIHMHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 08:07:53 -0400
Message-ID: <4320297F.2010602@bizmail.com.au>
Date: Thu, 08 Sep 2005 22:07:27 +1000
From: YH <yh@bizmail.com.au>
Reply-To: yh@bizmail.com.au
Organization: yh@bizmail.com.au, yhus@suers.sf.net, yudeh@rtunet.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: system IPC
References: <431ED4C1.6020406@bizmail.com.au> <Pine.LNX.4.61.0509070805430.7221@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0509070805430.7221@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any messaging mechanism (not signal) designed in kernel for 
drivers to communicate user mode asynchronously? If not, any reason why 
not using messaging in kernel as it is an effective and simple mechanism 
for embedded and real time system?

Thank you.

Cheers.

Jim

linux-os (Dick Johnson) wrote:
> On Wed, 7 Sep 2005, YH wrote:
> 
> 
>>It seems that the kernel disallows drivers to use system IPC.
>>Asynchronous communication mechanism is very effective mechanism among
>>various embedded OSes, even popular in RTOSes. Any reason why cannot use
>>sys_msgsnd and sys_msgrcv for kernel drivers?
>>
> 
> 
> Because they were not designed for use inside the kernel.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.13 on an i686 machine (5589.54 BogoMips).
> Warning : 98.36% of all statistics are fiction.
> .
> I apologize for the following. I tried to kill it with the above dot :
> 
> ****************************************************************
> The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
> 
> Thank you.
> 

