Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263858AbTDYKeG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 06:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263859AbTDYKeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 06:34:05 -0400
Received: from web20403.mail.yahoo.com ([66.163.169.91]:15390 "HELO
	web20415.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263858AbTDYKeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 06:34:05 -0400
Message-ID: <20030425104615.7429.qmail@web20415.mail.yahoo.com>
Date: Fri, 25 Apr 2003 03:46:15 -0700 (PDT)
From: devnetfs <devnetfs@yahoo.com>
Subject: Re: compiling modules with gcc 3.2
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1051261584.1391.4.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Arjan van de Ven <arjanv@redhat.com> wrote:

Thanks for the quick reply :)

> > Either way why is this so? AFAIK gcc 3.2 has abi incompatiblities
> > w.r.t. C++ and not C (which the kernel+modules are written in).
> 
> there are some cornercase C ABI changes but nobody except DAC960 will
> ever hit those. 

what are these? i am just curious about the change as i dont
see them (probably did not search hard) documented/listed on
gcc site. C++ ABI changes have some mention on some sites, but 
NOT on C ABI. 

> The more serious change is that the kernel contains
> workarounds for older compilers (the test used is major < 3) that
> changes the size of structures etc etc, and that breaks the module
> stuff.

so does this mean that: these workarounds now fixed in gcc 3.X?
and its just that the workaround employed in kernel source (for 
gcc 2.X) is different than the way gcc 3.X fixes them and hence 
objects generated from gcc 3.X and 2.X (w.r.t kernel sources+modules)
dont mix well?

thanks
A.

__________________________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo
http://search.yahoo.com
