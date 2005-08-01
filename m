Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVHADAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVHADAk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 23:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVHADAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 23:00:39 -0400
Received: from dsl017-059-136.wdc2.dsl.speakeasy.net ([69.17.59.136]:1419 "EHLO
	luther.kurtwerks.com") by vger.kernel.org with ESMTP
	id S262030AbVHADAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 23:00:37 -0400
Date: Sun, 31 Jul 2005 23:01:45 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove support for gcc < 3.2
Message-ID: <20050801030145.GE20899@kurtwerks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050731222606.GL3608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050731222606.GL3608@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.12.3
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 12:26:07AM +0200, Adrian Bunk took 109 lines to write:
> This patch removes support for gcc < 3.2 .
> 
> The advantages are:
> - reducing the number of supported gcc versions from 8 to 4 [1]
>   allows the removal of several #ifdef's and workarounds
> - my impression is that the older compilers are only rarely
>   used, so miscompilations of a driver with an old gcc might
>   not be detected for a longer amount of time
> 
> My personal opinion about the time and space a compilation requires is 
> that this is no longer that much of a problem for modern hardware, and 
> in the worst case you can compile the kernels for older machines on more 
> recent machines.

Environments that require kernel compilation, often multiple times, 
testing, benefit from shorter compile times. It can be the difference
between, say, completing a test suite overnight instead of having to
wait until tomorrow afternoon. Keeping 2.95, at least, has some value
in such environments.

Kurt
-- 
A chubby man with a white beard and a red suit will approach you soon.
Avoid him.  He's a Commie.
