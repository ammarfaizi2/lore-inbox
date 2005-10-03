Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbVJCQjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVJCQjc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVJCQjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:39:32 -0400
Received: from magic.adaptec.com ([216.52.22.17]:44419 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932306AbVJCQja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:39:30 -0400
Message-ID: <43415EC0.1010506@adaptec.com>
Date: Mon, 03 Oct 2005 12:39:28 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andrew.patterson@hp.com
CC: Marcin Dalecki <dalecki.marcin@neostrada.pl>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Linus Torvalds <torvalds@osdl.org>, Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>	 <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>	 <1128111290.10079.147.camel@bluto.andrew>  <433DA0DF.9080308@adaptec.com>	 <1128114950.10079.170.camel@bluto.andrew> <433DB5D7.3020806@adaptec.com>	 <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl>	 <4341381D.2060807@adaptec.com>	 <E93AC7D5-4CC0-4872-A5B8-115D2BF3C1A9@neostrada.pl> <1128357350.10079.239.camel@bluto.andrew>
In-Reply-To: <1128357350.10079.239.camel@bluto.andrew>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Oct 2005 16:39:29.0255 (UTC) FILETIME=[0631DF70:01C5C839]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/05 12:35, Andrew Patterson wrote:
> On Mon, 2005-10-03 at 18:29 +0200, Marcin Dalecki wrote:
>>They give a means of possible synchronization between beneviolent  
>>users, but not a mandatory lock on the shared resource.
>>
> 
> 
> Nor do they protect against external events, such as disk
> insertion/removals, and someone kicking a cable.

As has _always_ been the case in UNIX:  Provide capability,
not policy.

The more things are off loaded to userspace the better.

Look at it this way: the deadbolt on your house door does
not _eliminate_ the possibility of someone cleaning out
your house, even if you have a security system and/or
a guard dog.

Same thing here.
	Luben

