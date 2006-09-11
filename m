Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWIKNhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWIKNhl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 09:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWIKNhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 09:37:41 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:12979 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750815AbWIKNhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 09:37:40 -0400
Message-ID: <450566A2.1090009@garzik.org>
Date: Mon, 11 Sep 2006 09:37:38 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in libata-dev.git
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com>
In-Reply-To: <45056627.7030202@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergei Shtylyov wrote:
> Hello.
> 
> Jeff Garzik wrote:
>> The following libata changes are queued for 2.6.19:
>>
>> General
>> -------
>> * Increase lba28 max sectors from 200 to 256
> 
> [...]
> 
>> Jeff Garzik:
> [...]
>>       [ATA] Increase lba48 max-sectors from 200 to 256.
> 
>    So was it for LBA28 or for LBA48?
>    As for LBA28, it might be quite dangerous. Particularly, I know that 
> IBM drives used to mistreated 256 as 0 in the past (bumped into that on 
> a 8-year old drive which is still alive though).

That's a typo.  The first description ("lba28") is correct.

Let me know if your IBM drive has problems with current 
libata-dev.git#upstream...

	Jeff



