Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVC0Czo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVC0Czo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 21:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVC0Czo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 21:55:44 -0500
Received: from smtpout.mac.com ([17.250.248.71]:63727 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261398AbVC0Czi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 21:55:38 -0500
In-Reply-To: <1111886147.1495.3.camel@localhost>
References: <1111886147.1495.3.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <490243b66dc7c3f592df7a7d0769dcb7@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Date: Sat, 26 Mar 2005 21:55:33 -0500
To: Aaron Gyes <floam@sh.nu>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2005, at 20:15, Aaron Gyes wrote:
> How is what they are doing illegal? How it is even "bad"? They 
> obviously
> can't give up their IP. Them providing binary modules wrapped in GPL
> glue (so anyone can fix most kernel incompatabilities) is a good thing
> for Linux. Many people and businesses would not be using Linux if they
> did not do that.

I think that at the moment the general consensus is that it is ok to use
the Linux kernel APIs (but not the EXPORT_SYMBOL_GPL ones) from binary
modules _if_ _and_ _only_ _if_ the driver was originally written 
elsewhere
and ported to the Linux kernel.  Otherwise it's a derivative work, and
must therefore be GPLed.  Yes it's kinda draconian, but it's generally
been for the betterment of the Open Source community.

BTW, to all you "But my drivers must be proprietary!" nerds out there,
take a look at 3ware, Adaptec, etc.  They have _great_ hardware and yet
they release all of their drivers under the GPL.  They get free updates
to new kernel APIs too!

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


