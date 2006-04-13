Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWDMWRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWDMWRJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 18:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWDMWRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 18:17:09 -0400
Received: from rtr.ca ([64.26.128.89]:62906 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932474AbWDMWRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 18:17:08 -0400
Message-ID: <443ECDE3.5030805@rtr.ca>
Date: Thu, 13 Apr 2006 18:17:07 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mark Lord <lkml@rtr.ca>, Joshua Hudson <joshudson@gmail.com>,
       Ramakanth Gunuganti <rgunugan@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL issues
References: <20060411063127.97362.qmail@web54314.mail.yahoo.com>	 <20060411230642.GV23222@vasa.acc.umu.se>	 <bda6d13a0604111938j5ece401cid364582fe9d6cf76@mail.gmail.com>	 <443C716C.1060103@rtr.ca> <1144819887.3089.0.camel@laptopd505.fenrus.org>
In-Reply-To: <1144819887.3089.0.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2006-04-11 at 23:18 -0400, Mark Lord wrote:
>> Joshua Hudson wrote:
>>> On 4/11/06, David Weinehall <tao@acc.umu.se> wrote:
>>>> OK, simplified rules; if you follow them you should generally be OK:
>> ..
>>>> 3. Userspace code that uses interfaces that was not exposed to userspace
>>>> before you change the kernel --> GPL (but don't do it; there's almost
>>>> always a reason why an interface is not exported to userspace)
>>>>
>>>> 4. Userspace code that only uses existing interfaces --> choose
>>>> license yourself (but of course, GPL would be nice...)
>> Err.. there is ZERO difference between situations 3 and 4.
>> Userspace code can be any license one wants, regardless of where
>> or when or how the syscalls are added to the kernel.
> 
> that is not so clear if the syscalls were added exclusively for this
> application by the authors of the application....

Neither the GPL nor the kernel's COPYING file restricts anyone
from making kernel changes.  In fact, the GPL expressly permits
anyone to modify the kernel.  So how the syscalls get there is
of zero relevance here.

Now, the syscall interface itself appears to be expressly exempted
from any GPL considerations by the kernel's COPYING file:

>NOTE! This copyright does *not* cover user programs that use kernel
> services by normal system calls - this is merely considered normal use
> of the kernel, and does *not* fall under the heading of "derived work".

Heh.. but the lawyers are not completely out of their hourly fees yet,
since Linus unfortunately included that little undefined "normal" word.

Cheers
