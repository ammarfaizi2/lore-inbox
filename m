Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265075AbTFYV4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 17:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbTFYV4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 17:56:30 -0400
Received: from the.earth.li ([193.201.200.66]:3783 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S265075AbTFYV43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 17:56:29 -0400
Date: Wed, 25 Jun 2003 23:10:40 +0100
From: Jonathan McDowell <noodles@earth.li>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-ac3
Message-ID: <20030625221040.GA6743@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306251636.h5PGag417884@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not yet resynchronized with Marcelo 2.4.22-pre1.

I've had issues with 2.4.22-pre1 & 2.4.21-ac1 with PCMCIA & my orinoco
based wireless card (SMC 2632W) - as soon as I insert the card the
machine freezes.  Likewise with 2.4.21 normal. However 2.4.21-ac3 seems
to have fixed this.

Compiling with gcc 3.3; I thought this might be the problem and dropped
back to gcc 2.95, but 2.4.22-pre1 still hung.

Laptop is a Compaq N200; yenta CardBus driver compiled into the kernel.
pcmcia-cs 3.1.33; the machine will boot without the wireless card
inserted but hangs as soon as it is, or if inserted while booting hangs
when cardmgr starts.

Configs at:

http://the.earth.li/~noodles/config-2.4.21-ac3
http://the.earth.li/~noodles/config-2.4.22-pre1

J.

-- 
Ok ramblers, let's get rambling.
