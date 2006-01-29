Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWA2SWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWA2SWm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 13:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWA2SWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 13:22:42 -0500
Received: from cicero2.cybercity.dk ([212.242.40.53]:57595 "EHLO
	cicero2.cybercity.dk") by vger.kernel.org with ESMTP
	id S1751106AbWA2SWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 13:22:41 -0500
Message-ID: <43DD0850.8090705@vip.cybercity.dk>
Date: Sun, 29 Jan 2006 19:24:16 +0100
From: Mogens Valentin <mogensv@vip.cybercity.dk>
Reply-To: mogensv@vip.cybercity.dk
Organization: Mr Dev
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ahci: get JMicron JMB360 working
References: <20060129050434.GA19047@havoc.gtf.org> <200601291016.30459.prakash@punnoor.de>
In-Reply-To: <200601291016.30459.prakash@punnoor.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash Punnoor wrote:
> Am Sonntag Januar 29 2006 06:04 schrieb Jeff Garzik:
> 
> 
>>This patch, against latest 2.6.16-rc-git, adds support for JMicron and
>>fixes some code that should be Intel-only, but was being executed for
>>all vendors.
> 
> 
> Thx, works nicely here with JMicron jMB360 on an Asrock board.

Interesting. On 111105, I wrote to Asrock about Linux libata support for 
JM360, and mentioned Jeff Garzik as the developer/maintainer, along with 
his requirements for implementing JM360 libata support, but never got a 
reply from Asrock. I didn't get back to Garzik either; my apologies...

Due to other work, I didn't go on with that mobo, and partly because I 
saw no other products using JM360.
Nvidia hving bought ULi, I wonder what'll happen to ILi and Asrock.
I know that (fabless) Jmicron does chipset design and integration.

939Dual-SATA2 is interesting as an upgrade board due to performance, 
price, working PCIe/AGP and provisions for socket M2 via an adapter.
Whether this will actually work is of cause to be seen...
Now having libata SATA support gets it back into my thoughts.

@Prakash: Did you test with a SATA-2 disk?

-- 
Kind regards,
Mogens Valentin

