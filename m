Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbVHQGZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVHQGZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 02:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVHQGZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 02:25:11 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:40633 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S1750883AbVHQGZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 02:25:10 -0400
Message-ID: <4302D7D9.1020802@dresco.co.uk>
Date: Wed, 17 Aug 2005 07:23:21 +0100
From: Jon Escombe <lists@dresco.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>, yani.ioannou@gmail.com
Subject: Re: [Hdaps-devel] Re: HDAPS, Need to park the head for real
References: <1124205914.4855.14.camel@localhost.localdomain> <20050816200708.GE3425@suse.de> <1124234133.4855.73.camel@localhost.localdomain> <20050817055310.GG3425@suse.de>
In-Reply-To: <20050817055310.GG3425@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Hops: 1
X-Originating-Pythagoras-IP: [82.68.23.174]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>On Tue, Aug 16 2005, Alejandro Bonilla Beeche wrote:
>>>If I were in your position, I would just implement this for ide (pata,
>>>not sata) right now, since that is what you need to support (or do some
>>>of these notebooks come with sata?). So it follows that you add an ide
>>>      
>>>
>>Some notebooks are coming up with a Sata controller I think, but is
>>still and IDE drive. I think some T43's come with that.
>>
>>But, I will ask or check again later if we ever need this feature for
>>SATA.
>>    
>>
I can confirm that T43's are using libata.
I've tweaked the passthrough code to return the status registers (so we 
can tell whether the disk is parking sucessfully) 
http://groups.google.co.uk/group/fa.linux.kernel/browse_frm/thread/bd6b65dfcd1a3227

Regards,
Jon.



______________________________________________________________
Email via Mailtraq4Free from Enstar (www.mailtraqdirect.co.uk)
