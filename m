Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVKCMOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVKCMOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 07:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbVKCMOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 07:14:00 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38800 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964898AbVKCMN7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 07:13:59 -0500
Subject: Re: Would I be violating the GPL?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: alex@alexfisher.me.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com>
References: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Nov 2005 12:44:07 +0000
Message-Id: <1131021847.18848.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-01 at 17:49 +0000, Alexander Fisher wrote:
> Hello.
> 
> A supplier of a PCI mezzanine digital IO card has provided a linux 2.4
> driver as source code.  They have provided this code source with a
> license stating I won't redistribute it in anyway.
> My concern is that if I build this code into a module, I won't be able
> to distribute it to customers without violating either the GPL (by not
> distributing the source code), or the proprietary source code license
> as currently imposed by the supplier.


You need to ask a lawyer in the part of the world you plan to do this.
The area of law in question is quite murky and at the moment there is no
direct linux kernel caselaw of relevance that helps (at least that i
know of).

I suspect all kernel modules are probably derivative works but I am not
a lawyer and when you look at code which is large, shared with other
OS's and uses minimal kernel services it gets more complex.

For user space it isn't a problem and the kernel specifically clarifies
this in the copyright notice so as to avoid confusion or risk.


There is a second consideration however - your module will work only
with the exact gcc/kernel/options configuration you selected. That makes
binary modules problematic anyway as the kernel has an API not an ABI.
It would be far better to understand what the suppliers concern is and
to see if you can find an amicable way to distribute a GPL driver or
even get it into the base kernel that does not cause concerns for the
vendor. You may find the linux lab project and other digital I/O cards
with open drivers useful in persuading them of course ;)

