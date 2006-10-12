Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWJLIQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWJLIQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWJLIQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:16:33 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:32146 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S932506AbWJLIQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:16:31 -0400
Date: Thu, 12 Oct 2006 17:16:13 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>,
       Matt Domsch <Matt_Domsch@dell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com,
       davej@codemonkey.org.uk, trini@kernel.crashing.org, davem@davemloft.net,
       ecd@brainaid.de, wli@holomorphy.com, rc@rc0.org.uk, spyro@f2s.com,
       rth@twiddle.net, ralf@linux-mips.org, matthew@wil.cx,
       grundler@parisc-linux.org, geert@linux-m68k.org, zippel@linux-m68k.org,
       heiko.carstens@de.ibm.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net
Subject: Re: [PATCH 19/26] Dynamic kernel command-line - sh
Message-ID: <20061012081613.GA8559@linux-sh.org>
References: <200610112111.02040.alon.barlev@gmail.com> <200610112117.10698.alon.barlev@gmail.com> <200610112111.02040.alon.barlev@gmail.com> <200610112116.56120.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610112117.10698.alon.barlev@gmail.com> <200610112116.56120.alon.barlev@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 09:16:55PM +0200, Alon Bar-Lev wrote:
> 
> 1. Rename saved_command_line into boot_command_line.
> 2. Set command_line as __initdata.
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
> 
The sh bits look fine, though I'm fairly impartial to this change. It
doesn't seem like this is going to be needed in very many places..

In the future, you may also wish to CC linux-arch if you want the
attention of architecture maintainers.

Acked-by: Paul Mundt <lethal@linux-sh.org>

On Wed, Oct 11, 2006 at 09:17:10PM +0200, Alon Bar-Lev wrote:
> 
> 1. Rename saved_command_line into boot_command_line.
> 2. Set command_line as __initdata.
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
> 
Likewise for sh64.

Acked-by: Paul Mundt <lethal@linux-sh.org>
