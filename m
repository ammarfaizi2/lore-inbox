Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWIRNbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWIRNbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 09:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWIRNbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 09:31:06 -0400
Received: from smtpout.mac.com ([17.250.248.173]:16125 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964855AbWIRNbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 09:31:04 -0400
In-Reply-To: <Pine.LNX.4.61.0609181430530.30064@yvahk01.tjqt.qr>
References: <b681c62b0609160434g6ccbbaa0vd0cd68958696726e@mail.gmail.com> <450DE3DE.50301@redhat.com> <Pine.LNX.4.61.0609181033350.27566@yvahk01.tjqt.qr> <450E914C.90203@redhat.com> <Pine.LNX.4.61.0609181430530.30064@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A01B0745-4715-452E-847E-28F28C6EE34F@mac.com>
Cc: Rik van Riel <riel@redhat.com>, yogeshwar sonawane <yogyas@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: How much kernel memory is in 64-bit OS ?
Date: Mon, 18 Sep 2006 09:30:43 -0400
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAQAAA+k=
X-Language-Identified: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 18, 2006, at 08:34:25, Jan Engelhardt wrote:
>>>> Sure, people said that too when going from 16 bits to 32 bits,  
>>>> but that was only a factor 2^16 difference.  This time it's the  
>>>> square of the previous difference.
>>>
>>> Not quite the square :)
>>
>> 2^32 is the square of 2^16 :)
>
> As mentioned above, "the square of the previos" [16 to 32]  
> "difference".  Call me nitpicky, but:
>
> (2^32 - 2^16)^2  !=  (2^64 - 2^32)

Well into the nitpicking territory... I think you missed where he  
said "factor 2^16 difference".  So these:

> Going from 32 to 64:   (2^64 - 2^32)
> Going from 16 to 32:   (2^32 - 2^16)

Should actually be these:

Going from 32 to 64:	(2^64 / 2^32)
Going from 16 to 32:	(2^32 / 2^16)

And:

(2^32 / 2^16)^2 = (2^64 / 2^32) => (2^16)^2 = (2^32)

Cheers,
Kyle Moffett
