Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbUCKO5c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbUCKOzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:55:55 -0500
Received: from euw0000232-pip.eu.verio.net ([213.130.50.58]:64775 "EHLO
	euw0000232-pip.eu.verio.net") by vger.kernel.org with ESMTP
	id S261234AbUCKOx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:53:26 -0500
Message-ID: <40507D55.4040209@porism.com>
Date: Thu, 11 Mar 2004 14:53:09 +0000
From: Gerald Krafft <gkrafft@porism.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: hanging in wait_for_tcp_memory
References: <40505CA0.6080702@porism.com> <1079008948.4446.3.camel@laptop.fenrus.com>
In-Reply-To: <1079008948.4446.3.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Mar 2004 14:57:47.0890 (UTC) FILETIME=[37A03520:01C40779]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, so I will have to upgrade my system to a later kernel. It would 
still be nice if somebody could explain what this kernal function does, 
when it is usually called and under which circumstances it might block.

Gerald

Arjan van de Ven wrote:

> On Thu, 2004-03-11 at 13:33, Gerald Krafft wrote:
> 
>>I have some database processes (Interbase V6) that occasionally seem to 
>>hang. Using ps or top I found that they are waiting in 
>>wait_for_tcp_memory. What exactly does wait_for_tcp_memory do and under 
>>which circumstances does this function block?
>>I'm using Red Hat Linux 7.2, kernel version 2.4.7-10smp on a dual 
>>processor machine. Were there any known problems with 
>>wait_for_tcp_memory in that kernel version that might have been fixed in 
>>later versions
> 
> 
> 2.4.7-10 had a really really bad vm, so we replaced it with another
> kernel the day of 7.2 release (which also was needed for security
> fixes). Sounds like you need to apply a bunch of (security) errata to
> get your system performing better...


