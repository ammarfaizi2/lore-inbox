Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVA3Qz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVA3Qz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 11:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVA3Qzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 11:55:38 -0500
Received: from alg138.algor.co.uk ([62.254.210.138]:45804 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261729AbVA3Qz3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 11:55:29 -0500
Date: Sun, 30 Jan 2005 16:49:28 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: Re: [PATCH] Fix SERIAL_TXX9 dependencies
Message-ID: <20050130164928.GA27703@linux-mips.org>
References: <20050129131134.75dacb41.akpm@osdl.org> <20050129231255.GA3185@stusta.de> <20050130001555.GA3648@linux-mips.org> <20050130.220537.45151614.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050130.220537.45151614.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 10:05:37PM +0900, Atsushi Nemoto wrote:

> Well, "depends on MIPS || PCI" was intentional.  The driver can be
> used for both TX39/TX49 internal SIO and TC86C001 PCI chip.  TC86C001
> chip can be available for any platform with PCI bus (though I have
> never seen it on platform other than MIPS ...)

One encounter on #mipslinux a few days before your patch :-)

> So I suppose "depends on HAS_TXX9_SERIAL || PCI" might be better, but
> Ralf's patch will be OK for now.

I realize that || PCI would have been more correct but I'm considering
it an extremly rare configuration, so I left that out.  We sure can add
that if you think it's more apropriate.

  Ralf
