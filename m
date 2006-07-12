Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWGLRha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWGLRha (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWGLRha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:37:30 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:49929 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932154AbWGLRh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:37:29 -0400
Message-ID: <44B53324.7000305@shadowen.org>
Date: Wed, 12 Jul 2006 18:36:36 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Martin Bligh <mbligh@google.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: xfs fails dbench in 2.6.18-rc1-mm1
References: <44B52A19.3020607@google.com> <200607121912.52785.dada1@cosmosbay.com>
In-Reply-To: <200607121912.52785.dada1@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> On Wednesday 12 July 2006 18:58, Martin Bligh wrote:
>> http://test.kernel.org/abat/40891/debug/test.log.1
>>
>> Filesystem type for /mnt/tmp is xfs
>> write failed on handle 13786
>> 4 clients started
>> Child failed with status 1
>> write failed on handle 13786
>> write failed on handle 13786
>> write failed on handle 13786
>>
>> Works fine in -git4
>> All other fs's seemed to run OK.
>>
>> Machine is a 4x Opteron.
> 
> You need to revert 92eb7a2f28d551acedeb5752263267a64b1f5ddf

Will give reverting that a spin.

-apw
