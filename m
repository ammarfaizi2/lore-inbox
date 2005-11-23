Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbVKWQeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVKWQeU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVKWQeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:34:19 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:22229 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751241AbVKWQeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:34:17 -0500
Message-ID: <438499A9.1040409@tmr.com>
Date: Wed, 23 Nov 2005 11:32:41 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk>
In-Reply-To: <20051123150349.GA15449@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Nov 23, 2005 at 09:43:58AM -0500, Jon Smirl wrote:

>>Plus I have 64 tty devices. Couldn't the tty devices be created
>>dynamically as they are consumed? Same for the loop and ram devices?
> 
> 
> You do realise that the dynamic device creation for those 64 console
> devices is done via the console device being _opened_ by userspace?
> 
Which userspace program is opening 64 console devices? Surely it could 
be taught to use a smaller number. If you mean that open the console 
once creates all those devices, I think that's exactly what Jon was 
suggesting is not desirable (I agree).

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

