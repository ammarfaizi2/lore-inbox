Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbTKJQyR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 11:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263986AbTKJQyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 11:54:17 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:26073 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263985AbTKJQyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 11:54:15 -0500
Date: Mon, 10 Nov 2003 17:54:06 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: Some thoughts about stable kernel development
Message-ID: <20031110165406.GM22185@fs.tum.de>
References: <m3u15de669.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3u15de669.fsf@defiant.pm.waw.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09, 2003 at 07:41:02PM +0100, Krzysztof Halasa wrote:

> Hi,

Hi Krzysztof,

>...
> Here is what I propose:
> As all of you know, the development cycle can be shortened by using
> two separate trees for a stable kernel line.
> 
> Say, we're now at 2.4.23-rc1 stage. This "rc" kernel would also be
> known as 2.4.24-pre1. The maintainer would apply "rc"-class fixes to
> both kernels, and other patches (which can't go to "rc" kernel) would
> be applied to 2.4.24-pre1 only.
>...
> Comments?

I don't like this idea for the following reason:

A -rc kernel of a stable series needs maximum testing to avoid any 
regressions compared to the previous stable kernel.

If you start a new -pre series at the time of an -rc series many people 
will use the new -pre instead of the latest -rc decreasing the number of 
people testing this -rc and therefore increasing the risk of problems in 
the final kernel.

> Krzysztof Halasa, B*FH

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

