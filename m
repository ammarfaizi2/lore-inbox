Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbVJSVhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbVJSVhI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 17:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVJSVhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 17:37:08 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:11281 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751363AbVJSVhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 17:37:06 -0400
Message-ID: <4356BCB9.8080904@tmr.com>
Date: Wed, 19 Oct 2005 17:38:01 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Sequence of network cards
References: <20051019104712.GC9765@kestrel> <1129720556.2822.25.camel@laptopd505.fenrus.org>
In-Reply-To: <1129720556.2822.25.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>Is the algorithm for assignment of eth? numbers by Linux kernel
>>documented anywhere?
> 
> 
> it's generally on a pci bus order. However... if you switch to acpi by
> going from 2.4 to 2.6, the pci bus order might change.
> 
> The good news is that you can do a few things to mitigate this:
> 1) Several distros (including Fedora Core) allow you to bind ethX
> numbers to mac addresses, eg effectively persistent binding of ethX
> numbers to specific cards
> 2) you can rename ethX to ethY yourself with nameif and similar tools.

I knew about nameif, I was unaware of the bind to MAC solution, and 
thank you much for it. As the number of cards goes up it scales easily.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
