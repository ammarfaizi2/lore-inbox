Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWHIMta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWHIMta (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWHIMta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:49:30 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:9230 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750727AbWHIMt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:49:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QWN/rkhpwm13OHuUb7zMkIbk2NrbicDHjdZQTZOdXlPZVcZyvPI/VyxQ9GCxcBELX0H8+4n+GYZhJz4KLX/9XiE9ZgcKill7yGzt+8Mnc0zwbvQJ65+6rmm/kRGvd0Hff3AzeJ8fWauRTdvk89NRwFUUlKXI3OVLiwGC8H4NoYE=
Message-ID: <6bffcb0e0608090549q49f5a262g523d8d5e8004c455@mail.gmail.com>
Date: Wed, 9 Aug 2006 14:49:28 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andi Kleen" <ak@muc.de>
Subject: Re: mm snapshot broken-out-2006-08-08-00-59.tar.gz uploaded
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Jan Beulich" <jbeulich@novell.com>
In-Reply-To: <20060809014359.GB59180@muc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608080800.k7880noU028915@shell0.pdx.osdl.net>
	 <6bffcb0e0608081329r732e191dsec0f391ea70f7d28@mail.gmail.com>
	 <20060808140511.def9b13c.akpm@osdl.org>
	 <6bffcb0e0608081419p4430b5cei7b4aa990cd0d4422@mail.gmail.com>
	 <20060808143751.42f8d87c.akpm@osdl.org>
	 <6bffcb0e0608081511x17508f89j60705bf74e09e820@mail.gmail.com>
	 <20060809014359.GB59180@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Aug 2006 03:43:59 +0200, Andi Kleen <ak@muc.de> wrote:
> On Wed, Aug 09, 2006 at 12:11:38AM +0200, Michal Piotrowski wrote:
> > BUG: unable to handle kernel paging request at virtual address 01020304
> > printing eip:
> > c041b95c
> > *pde= 00000000
> > Oops: 0000 [#1]
> > 4K_STACK PREEMPT SMP
> > last sysfs file:
> > Modules linked in:
> > CPU 0
> > EIP: 0060: [<c041b95c>] Not tainted VLI
> > EFLAGS: 00010202
> > EIP is at kmem_cache_init+0x389/0x3f0
>
> Well it didn't crash in the unwinder.
> > [..]
>
> And that [..] isn't a unwinder problem, but a human operator error.
> Michal, you removed the valuable part of the backtrace.

No, I didn't. I haven't seen that oops. I don't have a serial console,
and the system hangs very early.

>
> -AndI
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
