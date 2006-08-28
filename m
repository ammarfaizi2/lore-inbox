Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWH1I2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWH1I2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWH1I23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:28:29 -0400
Received: from ns1.suse.de ([195.135.220.2]:15315 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751307AbWH1I22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:28:28 -0400
From: Andi Kleen <ak@suse.de>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Date: Mon, 28 Aug 2006 10:28:13 +0200
User-Agent: KMail/1.9.3
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, jdike@addtoit.com,
       B.Steinbrink@gmx.de, arjan@infradead.org, chase.venters@clientec.com,
       akpm@osdl.org, rmk+lkml@arm.linux.org.uk, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, dwmw2@infradead.org
References: <200608281003.02757.ak@suse.de> <200608281015.38389.ak@suse.de> <20060828.011929.66059812.davem@davemloft.net>
In-Reply-To: <20060828.011929.66059812.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608281028.13652.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 August 2006 10:19, David Miller wrote:

> I see it as duplication because the person who writes the
> kernel is the one who ends up writing the libc syscall
> bits or explains to the libc person for that arch how
> things work.  

And the way to explain it is to write the reference code.

> And once one libc implmenetation of this 
> exists, it can be used as a reference for other libc
> variants.

At least on x86-64 various glibc versions had quite buggy
syscall()s, that is why I never trusted it very much.
 
> Finally, once it's done, it's done, and that's it.

Except if you still have to deal with old user land.

-Andi
