Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVCTX2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVCTX2A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 18:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVCTX16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 18:27:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56846 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261380AbVCTXYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 18:24:43 -0500
Date: Sun, 20 Mar 2005 23:24:38 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pete Popov <ppopov@embeddedalley.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: Bitrotting serial drivers
Message-ID: <20050320232438.B31657@flint.arm.linux.org.uk>
Mail-Followup-To: Pete Popov <ppopov@embeddedalley.com>,
	Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
References: <20050319172101.C23907@flint.arm.linux.org.uk> <20050319141351.74f6b2a5.akpm@osdl.org> <20050320224028.GB6727@linux-mips.org> <423DFE7C.7040406@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <423DFE7C.7040406@embeddedalley.com>; from ppopov@embeddedalley.com on Sun, Mar 20, 2005 at 02:51:40PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2005 at 02:51:40PM -0800, Pete Popov wrote:
> >>>- __register_serial, register_serial, unregister_serial
> >>>  (this driver doesn't support PCMCIA cards, all of which are based on
> >>>   8250-compatible devices.)
>
> I tried a couple of times to cleanly add support to the 8250 for the Au1x 
> serial. The uart is just different enough to make that hard, though I admit I 
> never spent too much time on it. Sounds like it's time to revisit it again.

I would prefer to have a patch to remove (or ack to do so myself) the
above three mentioned functions so I can avoid breaking your driver,
rather than a large update to it.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
