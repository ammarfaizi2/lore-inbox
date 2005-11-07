Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVKGQvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVKGQvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVKGQvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:51:16 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:60425 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932238AbVKGQvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:51:15 -0500
Message-ID: <436F8601.4070201@vmware.com>
Date: Mon, 07 Nov 2005 08:51:13 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14: CR4 not needed to be inspected on the 486 anymore?
References: <Pine.LNX.4.55.0511031600010.24109@blysk.ds.pg.gda.pl> <436A3C10.9050302@vmware.com> <Pine.LNX.4.55.0511031639310.24109@blysk.ds.pg.gda.pl> <436AA1FD.3010401@vmware.com> <p73fyqb2dtx.fsf@verdi.suse.de> <Pine.LNX.4.55.0511070931560.28165@blysk.ds.pg.gda.pl> <436F7673.5040309@vmware.com> <Pine.LNX.4.55.0511071632110.28165@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0511071632110.28165@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2005 16:51:14.0811 (UTC) FILETIME=[77326CB0:01C5E3BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:

>On Mon, 7 Nov 2005, Zachary Amsden wrote:
>
>  
>
>>While this is at least no worse in the nested fault case than earlier 
>>kernels, I really wish I had one of those weird 486s so I could test the 
>>faulting mechanism.  It seems the trap handling code has gotten quite 
>>    
>>
>
> What's so weird about 486s?  Besides, for testing it doesn't have to be
>one -- you will get away with a 386, too.  I have neither anymore, but
>there are people around still using them.
>  
>

Because I hold in my hand "i486 Microprocessor Programmer's Reference 
Manual, c 1990", and it has no mention whatsoever of CR4, and all 
documentation I had until Friday had either no mention of CR4, or 
something to the effect of "new on Pentium, the CR4 register ..."  So 
I've had to re-adjust my definition of 486, which was weird.

Zach
