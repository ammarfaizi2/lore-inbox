Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUAEBlv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 20:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265842AbUAEBlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 20:41:51 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:9683 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265841AbUAEBls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 20:41:48 -0500
Date: Mon, 5 Jan 2004 02:41:22 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andi Kleen <ak@muc.de>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] disable gcc warnings of sign/unsigned comparison
Message-ID: <20040105014122.GW10569@fs.tum.de>
References: <19ahq-7Rg-11@gated-at.bofh.it> <19eEs-5lC-15@gated-at.bofh.it> <19kgS-4HT-19@gated-at.bofh.it> <m3pte3i17t.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3pte3i17t.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 02:33:10AM +0100, Andi Kleen wrote:
> Paul Jackson <pj@sgi.com> writes:
> 
> > Right now, compiling a 2.6.0-mm1 (what I had handy) with the 3.3 gcc on
> 
> That was a bug in gcc 3.3.0. It had the -Wsign-compare warning 
> enabled in -Wall by mistake. Update to gcc 3.3.1, which has this fixed.

Wrong.

It was _not_ a bug in gcc 3.3 .

It was a bug in some _prerelease_ versions of gcc 3.3 SuSE decided to 
ship in a release of their distribution.

There is no officially released version of gcc with this problem.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

