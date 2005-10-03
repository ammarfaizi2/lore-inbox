Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932649AbVJCTTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbVJCTTm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbVJCTTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:19:42 -0400
Received: from outgoing.tpinternet.pl ([193.110.120.20]:15059 "EHLO
	outgoing.tpinternet.pl") by vger.kernel.org with ESMTP
	id S932606AbVJCTTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:19:41 -0400
In-Reply-To: <43415EC0.1010506@adaptec.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>	 <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>	 <1128111290.10079.147.camel@bluto.andrew>  <433DA0DF.9080308@adaptec.com>	 <1128114950.10079.170.camel@bluto.andrew> <433DB5D7.3020806@adaptec.com>	 <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl>	 <4341381D.2060807@adaptec.com>	 <E93AC7D5-4CC0-4872-A5B8-115D2BF3C1A9@neostrada.pl> <1128357350.10079.239.camel@bluto.andrew> <43415EC0.1010506@adaptec.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0D927995-1605-4AA7-B213-2AE7F3C6CD69@neostrada.pl>
Cc: andrew.patterson@hp.com, "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       dougg@torque.net, Linus Torvalds <torvalds@osdl.org>,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Date: Mon, 3 Oct 2005 21:16:28 +0200
To: Luben Tuikov <luben_tuikov@adaptec.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-10-03, at 18:39, Luben Tuikov wrote:

> On 10/03/05 12:35, Andrew Patterson wrote:
>
>> On Mon, 2005-10-03 at 18:29 +0200, Marcin Dalecki wrote:
>>
>>> They give a means of possible synchronization between beneviolent
>>> users, but not a mandatory lock on the shared resource.
>>
>> Nor do they protect against external events, such as disk
>> insertion/removals, and someone kicking a cable.
>
> As has _always_ been the case in UNIX:  Provide capability,
> not policy.

This is at least arguable and not applicable, since we are talking  
about Linux and not UNIX here. UNIX is just fine using IOCTL or  
SYSCTL instead of a crude pseudo file system for this kind of things.

> The more things are off loaded to userspace the better.

That is not the question at hand and an invalid statement per se.  
It's not a design goal in itself to have everything in user space.  
However you admitt indirectly that the problem in question is valid  
and that it exists on the design level of the interface at hand and  
that it's an inherent error in this interface, since you don't know a  
solution to it.

> Look at it this way: the deadbolt on your house door does
> not _eliminate_ the possibility of someone cleaning out
> your house, even if you have a security system and/or
> a guard dog.

Problems which can be solved by proper solutions easly and without  
cost should be solved and not talked away to justify someones idee  
fixe about interface desing.
