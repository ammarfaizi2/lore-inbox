Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWFLVoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWFLVoS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWFLVoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:44:18 -0400
Received: from www.osadl.org ([213.239.205.134]:2742 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932263AbWFLVoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:44:17 -0400
Subject: Re: [PATCH] x86 built-in command line
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Tim Bird <tim.bird@am.sony.com>
Cc: Matt Mackall <mpm@selenic.com>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <448DDE46.2020602@am.sony.com>
References: <20060611215530.GH24227@waste.org>
	 <200606121712.k5CHClUE017185@terminus.zytor.com>
	 <20060612204925.GT24227@waste.org>
	 <1150147153.5257.277.camel@localhost.localdomain>
	 <448DDE46.2020602@am.sony.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 23:45:07 +0200
Message-Id: <1150148707.5257.284.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 14:36 -0700, Tim Bird wrote:
> Thomas Gleixner wrote:
> > Well most of the bootloaders I'm working with let me change the
> > commandline. 
> 
> Just FYI for this thread, most of the bootloaders I work with
> don't let me change the kernel command line.  Many have no
> knowledge of Linux whatsoever.  Many boards, especially internal
> boards, have hobbled-together custom bootloaders.
> 
> Hence, I've gotten out of the habit of figuring out how to set
> the command line args from the bootloader even for those
> platforms where the bootloader *is* capable of it.

Which is not a problem with the (b) variant where the bootloader
provided command line replaces the compiled in one. It does not change
your habit of not setting up a commandline - or an empty one. 

This would also ensure compability with grub and friends, which I
consider as a real strong argument to avoid breakage all over the place.

	tglx
 

