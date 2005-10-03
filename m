Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVJCNyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVJCNyx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 09:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVJCNyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 09:54:53 -0400
Received: from magic.adaptec.com ([216.52.22.17]:64955 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932071AbVJCNyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 09:54:52 -0400
Message-ID: <4341381D.2060807@adaptec.com>
Date: Mon, 03 Oct 2005 09:54:37 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcin Dalecki <dalecki.marcin@neostrada.pl>
CC: andrew.patterson@hp.com, "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       dougg@torque.net, Linus Torvalds <torvalds@osdl.org>,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>	 <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>	 <1128111290.10079.147.camel@bluto.andrew>  <433DA0DF.9080308@adaptec.com> <1128114950.10079.170.camel@bluto.andrew> <433DB5D7.3020806@adaptec.com> <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl>
In-Reply-To: <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Oct 2005 13:54:38.0392 (UTC) FILETIME=[FEC7F380:01C5C821]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/05 19:42, Marcin Dalecki wrote:
> On 2005-10-01, at 00:01, Luben Tuikov wrote:
> 
>>Why should synchronization between Process A and Process B
>>reading storage attributes take place in the kernel?
>>
>>They can synchronize in user space.
> 
> 
> In a mandatory and transparent way? How?

Futex, userspace mutex, etc.  All through a user
space library interface.

	Luben

