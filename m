Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132908AbRDEOrj>; Thu, 5 Apr 2001 10:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132951AbRDEOr3>; Thu, 5 Apr 2001 10:47:29 -0400
Received: from ns2.cypress.com ([157.95.67.5]:40110 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S132908AbRDEOrP>;
	Thu, 5 Apr 2001 10:47:15 -0400
Message-ID: <3ACC8538.8B2532FC@cypress.com>
Date: Thu, 05 Apr 2001 09:46:16 -0500
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Config printk buffer size
In-Reply-To: <200104050947.LAA08111@sunrise.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz wrote:
> 
> IMO, it would be nice to add a test here whether the CONFIG_PRINTK_BUF_LEN
> value is really set as a power of two, eg.:
> 
> #if (LOG_BUF_LEN & LOG_BUF_MASK)
> #error CONFIG_PRINTK_BUF_LEN must be a power of two
> #endif

I couldn't figure out how to do it in the config,
forgot about preprocessing. But Alan wants a menu
option instead.

Anyone who uses the embedded systems want
a different default? Let me know and I'll
put it in the default config files.
I'm sure a small hand held with fixed devices
doesn't need even a 8K buffer. Just don't know
which ones.

	-Thomas
