Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVBHUFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVBHUFT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 15:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVBHUFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 15:05:19 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55568 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261649AbVBHUFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 15:05:07 -0500
Date: Tue, 8 Feb 2005 20:05:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ARM undefined symbols.  Again.
Message-ID: <20050208200501.B3544@flint.arm.linux.org.uk>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20050124154326.A5541@flint.arm.linux.org.uk> <20050131161753.GA15674@mars.ravnborg.org> <20050207114359.A32277@flint.arm.linux.org.uk> <20050208194243.GA8505@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050208194243.GA8505@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Feb 08, 2005 at 08:42:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 08:42:43PM +0100, Sam Ravnborg wrote:
> On Mon, Feb 07, 2005 at 11:43:59AM +0000, Russell King wrote:
> > 
> > Maybe we need an architecture hook or something for post-processing
> > vmlinux?
> Makes sense.
> For now arm can provide an arm specific cmd_vmlinux__ like um does.
> 
> The ?= used in Makefile snippet below allows an ARCH to override the
> definition of quiet_cmd_vmlinux__ and cmd_vmlinux__

Great - I'll merge your previous idea with this one and throw a patch
here.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
