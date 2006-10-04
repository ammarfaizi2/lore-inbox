Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030716AbWJDR50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030716AbWJDR50 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030726AbWJDR50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:57:26 -0400
Received: from rtr.ca ([64.26.128.89]:2310 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030716AbWJDR5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:57:24 -0400
Message-ID: <4523F602.6070608@rtr.ca>
Date: Wed, 04 Oct 2006 13:57:22 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in libata-dev.git
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com>
In-Reply-To: <45056627.7030202@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergei Shtylyov wrote:
> ..
>> Jeff Garzik:
> [...]
>>       [ATA] Increase lba48 max-sectors from 200 to 256.
> 
>    So was it for LBA28 or for LBA48?
>    As for LBA28, it might be quite dangerous. Particularly, I know that 
> IBM drives used to mistreated 256 as 0 in the past (bumped into that on 
> a 8-year old drive which is still alive though).
..
>The exact model was IBM DHEA-34331. 

I've been travelling for the past month, so pardon the late tuning in here.
I've *never* encountered a drive that had this problem.
Controllers, yes, and those are easily dealt with in the chipset drivers.

But never drives.  Not since 1992 when I first took up Linux IDE stuff.

I have some 7-year old IBM drives here, and they certainly don't have
this problem either (but they do have working TCQ etc..).

I suspect Sergei simply had a bad controller card at the time.

Cheers
