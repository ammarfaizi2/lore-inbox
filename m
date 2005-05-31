Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVEaBVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVEaBVj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 21:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVEaBVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 21:21:39 -0400
Received: from mail.dvmed.net ([216.237.124.58]:1261 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261581AbVEaBVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 21:21:37 -0400
Message-ID: <429BBC1B.1060402@pobox.com>
Date: Mon, 30 May 2005 21:21:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SATA NCQ support
References: <48Hix-88s-7@gated-at.bofh.it> <48N4N-4B5-25@gated-at.bofh.it> <48Pzt-6Kb-5@gated-at.bofh.it> <429BA937.2090802@shaw.ca>
In-Reply-To: <429BA937.2090802@shaw.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Jeff Garzik wrote:
> 
>> Matthias Andree wrote:
>>
>>> OK, so this is for AHCI. What are the options for people whose
>>> mainboards aren't blessed with AHCI, but use for instance VIA or older
>>> Promise chips? Buy new hardware? Or wait until someone comes up with an
>>> implementation?
>>
>>
>>
>> As Jens mentioned, NCQ support requires both device and hardware have 
>> explicit NCQ support.  That eliminates most of Linux's supported SATA 
>> controllers, none of which support NCQ.
>>
>> Don't have a heart attack, though, SATA is pretty fast even without NCQ.
>>
> 
> NVIDIA nForce4 supports NCQ under Windows.. any word on whether docs may 
> become available to allow this to be supported under Linux? You'd think 
> NVIDIA would want to get that support in..

NVIDIA is the only company that hasn't been willing to give me any SATA 
docs access, so who knows.

NVIDIA themselves wrote sata_nv, so presumably they'll support it 
whenever people poke them enough.

	Jeff



