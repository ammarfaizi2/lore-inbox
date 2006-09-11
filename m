Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWIKOok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWIKOok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 10:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWIKOok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 10:44:40 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:40373 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932232AbWIKOoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 10:44:39 -0400
Message-ID: <45057651.8000404@garzik.org>
Date: Mon, 11 Sep 2006 10:44:33 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in libata-dev.git
References: <20060911132250.GA5178@havoc.gtf.org>	 <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org>	 <450568F3.3020005@ru.mvista.com> <1157986974.23085.147.camel@localhost.localdomain>
In-Reply-To: <1157986974.23085.147.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Llu, 2006-09-11 am 17:47 +0400, ysgrifennodd Sergei Shtylyov:
>>     It's not likely I'll be able to try it. But I'm absolutely sure that drive 
>> aborted the read commands with the sector count of 0 (i.e. 256 actually). The 
>> exact model was IBM DHEA-34331.
> 
> Several people reported this problem when we tried 256 years ago in
> drivers/ide. You might want to do 256 for SATA Jeff but please don't do
> 256 for PATA. Reading specs is too hard for some people ;)
> 
> Some drives abort the xfer, some just choked.

Where in drivers/ide is it limited to 255?

	Jeff



