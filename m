Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWHTDUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWHTDUq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 23:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWHTDUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 23:20:46 -0400
Received: from relay02.pair.com ([209.68.5.16]:61701 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751473AbWHTDUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 23:20:45 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: GPL Violation?
Date: Sat, 19 Aug 2006 22:20:19 -0500
User-Agent: KMail/1.9.4
Cc: David Schwartz <davids@webmaster.com>, alan@lxorguk.ukuu.org.uk,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <1155919950.30279.8.camel@localhost.localdomain> <MDEHLPKNGKAHNMBLJOLKEEBCNOAB.davids@webmaster.com> <20060819113052.GC3190@aitel.hist.no>
In-Reply-To: <20060819113052.GC3190@aitel.hist.no>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608192220.42456.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 August 2006 06:30, Helge Hafting wrote:
> Now, if someone actually distributes a closed-source module that
> circumvents EXPORT_SYMBOL_GPL, or relies on an accompagnying
> open source patch that removes the mechanism, this happens:
>
> 1. By doing this, they clearly showed that their module is outside the
>    gray area of "allowed binary-only modules". They definitively
>    made a "derived work" and distributed it.
>
> 2. Anybody who received this module may now invoke the GPL
>    (and the force of law, if necessary) to extract the
>    module source code from the maker.  And then this source
>    can be freely redistributed to all interested.

Actually, you can't just force the vendor to open up all of their source code. 
The GPL isn't a contract - it's a license. If a vendor makes a derived work 
from the Linux kernel and does not GPL-license said derived work, they are 
indeed violating copyright as the license the GPL provides no longer supports 
their ability to redistribute.

However, the court decides what happens to the vendor. The court might force 
the vendor to open up their code, but to my knowledge this would be breaking 
brand new ground. I think it is more likely that the plaintiff could be 
awarded monetary damages and the defendant enjoined from further 
redistribution.

The charge is not "violating the GPL" (since the GPL is not a contract) -- 
it's distributing copyrighted materials without a license. See Eben Moglen's 
discussion on this subject for more details.

Thanks,
Chase
