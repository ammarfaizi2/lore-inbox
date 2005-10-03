Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVJCQgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVJCQgJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVJCQgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:36:08 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:10931 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932347AbVJCQgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:36:06 -0400
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
	the kernel
From: Andrew Patterson <andrew.patterson@hp.com>
Reply-To: andrew.patterson@hp.com
To: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Linus Torvalds <torvalds@osdl.org>, Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E93AC7D5-4CC0-4872-A5B8-115D2BF3C1A9@neostrada.pl>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>
	 <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>
	 <1128111290.10079.147.camel@bluto.andrew>  <433DA0DF.9080308@adaptec.com>
	 <1128114950.10079.170.camel@bluto.andrew> <433DB5D7.3020806@adaptec.com>
	 <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl>
	 <4341381D.2060807@adaptec.com>
	 <E93AC7D5-4CC0-4872-A5B8-115D2BF3C1A9@neostrada.pl>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 10:35:50 -0600
Message-Id: <1128357350.10079.239.camel@bluto.andrew>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-03 at 18:29 +0200, Marcin Dalecki wrote:
> On 2005-10-03, at 15:54, Luben Tuikov wrote:
> 
> > On 09/30/05 19:42, Marcin Dalecki wrote:
> >
> >> On 2005-10-01, at 00:01, Luben Tuikov wrote:
> >>
> >>
> >>> Why should synchronization between Process A and Process B
> >>> reading storage attributes take place in the kernel?
> >>>
> >>> They can synchronize in user space.
> >>>
> >>
> >>
> >> In a mandatory and transparent way? How?
> >
> > Futex, userspace mutex, etc.  All through a user
> > space library interface.
> 
> They give a means of possible synchronization between beneviolent  
> users, but not a mandatory lock on the shared resource.
> 

Nor do they protect against external events, such as disk
insertion/removals, and someone kicking a cable.


