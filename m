Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbUB0KWV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbUB0KWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:22:21 -0500
Received: from server0027.freedom2surf.net ([194.106.33.36]:23529 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id S261770AbUB0KWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:22:20 -0500
Date: Fri, 27 Feb 2004 10:21:29 +0000
From: Ian Molton <spyro@f2s.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: bunk@fs.tum.de, scottb@rebel.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove kernel 2.0 #ifdef's from arm{,26} code
Message-Id: <20040227102129.30429558.spyro@f2s.com>
In-Reply-To: <20040227101602.B17462@flint.arm.linux.org.uk>
References: <20040226224333.GW5499@fs.tum.de>
	<20040227101602.B17462@flint.arm.linux.org.uk>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.8-gtk2-20031212 (GTK+ 2.2.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 10:16:02 +0000
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Thu, Feb 26, 2004 at 11:43:34PM +0100, Adrian Bunk wrote:
> > The patch below removes #ifdef's for kernel 2.0 from 
> > arch/arm{,26}/nwfpe/fpmodule.c .
> > 
> > Please apply
> 
> I've applied the ARM bit (not the ARM26).  I've also moved these
> two the end of the file, and added an appropriate MODULE_LICENSE.

I will be doing the same for arm26, however it is my hope that arm26
will become softfloat-only in the long term.

-- 
Spyros lair: http://www.mnementh.co.uk/   ||||   Maintainer: arm26 linux

Do not meddle in the affairs of Dragons, for you are tasty and good with
ketchup.
