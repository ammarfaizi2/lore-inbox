Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVFBJ2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVFBJ2Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 05:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVFBJ2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 05:28:24 -0400
Received: from sanosuke.troilus.org ([66.92.173.88]:61829 "EHLO
	sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S261314AbVFBJ0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 05:26:54 -0400
To: kallol@nucleodyne.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: SPI-4 device support on linux
From: Michael Poole <mdpoole@troilus.org>
Date: Thu, 02 Jun 2005 05:26:52 -0400
In-Reply-To: <20050602023436.u0kjvng924e84g44@www.nucleodyne.com> (kallol@nucleodyne.com's
 message of "Thu, 02 Jun 2005 02:34:36 -0400")
Message-ID: <87mzq9hzxf.fsf@sanosuke.troilus.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
References: <20050602023436.u0kjvng924e84g44@www.nucleodyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kallol@nucleodyne.com writes:

> Hello,
>      We have been evaluating a project to develop linux driver
> and stack for SPI-4 devices. SPI-4 stands for System Packet Interface
> Level 4.
>
> While searching on internet I came across a few articles on SPI-4 protocol.
> One of the links is given below:
>
> http://www.altera.com/products/devices/stratixgx/features/sgx-spi.html
>
>
> Is there any update on linux driver support for SPI-4 devices?

You can get the specifications for the SPI family of interfaces at
http://www.oiforum.com/public/impagreements.html .  However, it is an
electrical (physical and link layer) interface.  It does not specify a
host interface, since the interesting feature of most devices is not
an SPI-4 interface.

There may be cards out there that do have SPI-4 interfaces and Linux
drivers, but the two are not necessarily related: the likely problem
areas for a device driver are those shared with any 10 Gbit card, and
are not specific to SPI-4 cards.

Michael Poole
