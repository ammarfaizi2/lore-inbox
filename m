Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945944AbWJZVqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945944AbWJZVqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 17:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945945AbWJZVqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 17:46:04 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16140 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945944AbWJZVqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 17:46:01 -0400
Date: Thu, 26 Oct 2006 23:46:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Roskin <proski@gnu.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
Message-ID: <20061026214600.GL27968@stusta.de>
References: <1161807069.3441.33.camel@dv> <1161808227.7615.0.camel@localhost.localdomain> <20061025205923.828c620d.akpm@osdl.org> <1161859199.12781.7.camel@localhost.localdomain> <1161890340.9087.28.camel@dv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161890340.9087.28.camel@dv>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 03:19:00PM -0400, Pavel Roskin wrote:
>...
> 
> This means that ndiswrapper would be considered as a derived work of
> Linux.  Since ndiswrapper is under GPL, it would suffer unfairly if the
> meaning of EXPORT_SYMBOL_GPL is extended to restrict GPLed modules
> capable of loading proprietary code into the kernel.
>...

You could always write a tiny GPL-ed wrapper module with the sole 
purpose of offering all EXPORT_SYMBOL_GPL'ed functions through 
EXPORT_SYMBOL'ed wrapper functions.

You are using a gnu.org address for publically stating that trying to 
prevent such kinds of wrapping was unfair?

It's not even clear that any modules containing non-GPL'ed code were 
legal.

EXPORT_SYMBOL_GPL shows a pretty clear intention, and offering 
functionality provided throug h EXPORT_SYMBOL_GPL'ed symbols to 
proprietary code sounds very fishy.

> Regards,
> Pavel Roskin

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

