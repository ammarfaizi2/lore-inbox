Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423544AbWJZPCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423544AbWJZPCb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 11:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbWJZPCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 11:02:31 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:38379 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1752119AbWJZPCa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 11:02:30 -0400
Message-ID: <4540CDFE.4000003@compro.net>
Date: Thu, 26 Oct 2006 11:02:22 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Erik Mouw <erik@harddisk-recovery.com>, dmarkh@cfl.rr.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Another kernel releated GPL ?
References: <4540839C.6010302@cfl.rr.com>	 <1161861128.12781.28.camel@localhost.localdomain>	 <45409BFA.8000507@compro.net>	 <20061026121041.GB12420@harddisk-recovery.com>	 <4540B414.7040406@compro.net> <1161872508.12781.42.camel@localhost.localdomain>
In-Reply-To: <1161872508.12781.42.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-10-26 am 09:11 -0400, ysgrifennodd Mark Hounschell:
>> Some code is added directly to the kernel source tree. A user land library is
>> written to access the changes. It is not GPL or LGPL. Simple scenario. No? I
>> thought so at least.
> 
> It isn't a simple scenario because it depends what you are adding and
> how the two parts interact, eg how generic they are.
> 

Thats one of the things I don't understand. How could a lawyer be qualified
enough to actually give proper advise on this. And how will a court be able to
make a proper decision if it had to. It seems to me they both would have to ask
you all.

> Take a memory allocator - if I put a malloc implementation in the kernel
> for some strange reason that provides malloc/free/realloc then a library
> making use of those clearly isn't very closely tied - they are generic
> functions.
> 
> Now suppose I have a device driver that is part kernel and part user
> space that calls from one to the other for very specific functions that
> are only of use to that driver.
> 

Hmm.

> In the usual case it doesn't matter, much stuff is GPL anyway, and for
> the usual system calls/C library stuff not only is the law probably
> fairly well established but there is an explicit statement with the
> kernel that we don't want to claim such rights for a normal system call
> which would guide a Judge if a case ever came up.
> 
> 

That's sort of what I was in search of. Where is this "explicit statement" found
BTW.

Thanks
Mark



