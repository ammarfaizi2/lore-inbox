Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWDKQPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWDKQPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 12:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWDKQPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 12:15:39 -0400
Received: from smtpout.mac.com ([17.250.248.97]:24269 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750961AbWDKQPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 12:15:38 -0400
In-Reply-To: <20060411154944.65714.qmail@web54308.mail.yahoo.com>
References: <20060411154944.65714.qmail@web54308.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DCEBF051-8627-44BC-B15C-7E716E1E509B@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: GPL issues
Date: Tue, 11 Apr 2006 12:15:34 -0400
To: Ramakanth Gunuganti <rgunugan@yahoo.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 11, 2006, at 11:49:44, Ramakanth Gunuganti wrote:
> Thanks for the replies, talking to a lawyer seems to be too  
> stringent a requirement to even evaluate Linux.  Who would be the  
> ultimate authority to give definitive answers to these questions?

Once again, as I said before, a lawyer.  There are currently very few  
GPL-related precedents, and none on that particular topic.  The best  
place to get advice is a lawyer.   Think of it as though you were  
licensing some code from another proprietary company for inclusion in  
your product; there you would _definitely_ talk to a lawyer.  The  
"ultimate authority" is your local/regional/national courts, a local  
lawyer is best able to use your particular set of laws to interpret  
what your courts are likely to decide and advise you accordingly.   
Nobody on this list can give you that kind of legal advice, at least  
not for free.

> Since it's the Linux kernel that's under GPLv2, any work done here  
> should be released under GPLv2.

Any "Derivative Work" of the Linux kernel must be licensed under the  
GPL.  The definition of "Derivative Work" is hard to resolve in  
detail.  Most kernel developers (including Linus himself) believe  
that all kernel modules are derivative works due to the unique and  
variable nature of the in-kernel APIs.  It is almost always held that  
userspace-only programs are _not_ derivative works.  On the other  
hand, if you export some kernel-internal API directly to userspace  
through a syscall, any program that uses it might be considered a  
derivative work.

> Can we just claim that part of the package is under GPL and only  
> release the source code for the kernel portions.

It really depends, which is why I suggest you contact a lawyer versed  
in this field.  Virtually none of the people on this list can give  
you any definitive answers, especially without access to the product  
itself, and even then they would most likely just tell you of their  
personal opinion which has no legal weight whatsoever.

Cheers,
Kyle Moffett
