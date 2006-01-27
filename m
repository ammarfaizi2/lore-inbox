Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWA0Pbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWA0Pbr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 10:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWA0Pbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 10:31:47 -0500
Received: from [198.99.130.12] ([198.99.130.12]:41392 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751239AbWA0Pbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 10:31:46 -0500
Date: Fri, 27 Jan 2006 10:32:40 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Gerd Hoffmann <kraxel@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/2] uml: enable drivers (input, fb, vt)
Message-ID: <20060127153240.GA4992@ccure.user-mode-linux.org>
References: <43D64F05.90302@suse.de> <20060124213141.GA7891@ccure.user-mode-linux.org> <43D744B2.5030809@suse.de> <20060127035732.GA12763@ccure.user-mode-linux.org> <43DA01B1.8040504@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DA01B1.8040504@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 12:19:13PM +0100, Gerd Hoffmann wrote:
> Looks ok.  What kernel command line do you boot the kernel with?  Any
> console=something in there?  Any changes if you append "console=tty0"?

This is what I'm using:

./fb-obj/linux con0=fd:0,fd:1 con1=none con=pts ssl=pts mem=192M ubda=~/linux/debian_22 umid=debian x11=640x480

Adding "console=tty0" doesn't change anything.

				Jeff
