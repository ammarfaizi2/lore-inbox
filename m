Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263887AbTJEWWS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 18:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTJEWWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 18:22:18 -0400
Received: from lewis.CNS.CWRU.Edu ([129.22.104.62]:54049 "EHLO
	lewis.CNS.CWRU.Edu") by vger.kernel.org with ESMTP id S263887AbTJEWWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 18:22:12 -0400
Date: Sun, 05 Oct 2003 18:22:11 -0400
From: Justin Hibbits <jrh29@po.cwru.edu>
Subject: Re: regression between 2.4.18 and 2.4.21/22
In-reply-to: <20031005215803.GF1205@matchmail.com>
To: linux-kernel@vger.kernel.org
Message-id: <5D69CB34-F782-11D7-86F4-000A95841F44@po.cwru.edu>
MIME-version: 1.0
X-Mailer: Apple Mail (2.552)
Content-type: text/plain; format=flowed; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, Oct 5, 2003, at 17:58 America/New_York, Mike Fedyk wrote:

> On Sun, Oct 05, 2003 at 04:21:06PM -0400, Justin Hibbits wrote:
>> which now get sustained transfer rates of 46MB/s or greater.  I'm 
>> using
>> the same options for all 3 kernels (at least, for the ATA/IDE 
>> options).
>>  Any help would be appreciated, and I'll see if maybe I could do
>> something with it when I get time.
>
> Some drivers have been split, or renamed.  Make sure you have the 
> driver for
> your chipset compiled in, and you're not using generic ide dma.

I'm using the PROMISE drivers (the only ones listed in the kernel 
config), and Generic is also compiled in.  It wasn't compiled in 
2.4.21, so I tried compiling it in, and it still didn't work, tried 
changing the "Ignore word93 Validation Bits" option, but that still 
didn't help.  Guess I should just take a crack at the source itself.

-Justin

