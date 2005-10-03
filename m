Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVJCQbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVJCQbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVJCQbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:31:24 -0400
Received: from outgoing.tpinternet.pl ([193.110.120.20]:19149 "EHLO
	outgoing.tpinternet.pl") by vger.kernel.org with ESMTP
	id S1751164AbVJCQbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:31:23 -0400
In-Reply-To: <4341381D.2060807@adaptec.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>	 <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>	 <1128111290.10079.147.camel@bluto.andrew>  <433DA0DF.9080308@adaptec.com> <1128114950.10079.170.camel@bluto.andrew> <433DB5D7.3020806@adaptec.com> <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl> <4341381D.2060807@adaptec.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E93AC7D5-4CC0-4872-A5B8-115D2BF3C1A9@neostrada.pl>
Cc: andrew.patterson@hp.com, "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       dougg@torque.net, Linus Torvalds <torvalds@osdl.org>,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Date: Mon, 3 Oct 2005 18:29:02 +0200
To: Luben Tuikov <luben_tuikov@adaptec.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-10-03, at 15:54, Luben Tuikov wrote:

> On 09/30/05 19:42, Marcin Dalecki wrote:
>
>> On 2005-10-01, at 00:01, Luben Tuikov wrote:
>>
>>
>>> Why should synchronization between Process A and Process B
>>> reading storage attributes take place in the kernel?
>>>
>>> They can synchronize in user space.
>>>
>>
>>
>> In a mandatory and transparent way? How?
>
> Futex, userspace mutex, etc.  All through a user
> space library interface.

They give a means of possible synchronization between beneviolent  
users, but not a mandatory lock on the shared resource.
