Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbTHZAPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 20:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTHZAPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 20:15:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50450 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262203AbTHZAPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 20:15:15 -0400
Date: Tue, 26 Aug 2003 01:15:09 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: David Hinds <dhinds@sonic.net>
Cc: damjan@bagra.net.mk, linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
       dahinds@users.sourceforge.net
Subject: Re: Trivial patch for drivers/serial/8250_cs
Message-ID: <20030826011509.K16790@flint.arm.linux.org.uk>
Mail-Followup-To: David Hinds <dhinds@sonic.net>, damjan@bagra.net.mk,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
	dahinds@users.sourceforge.net
References: <3F4A7F2C.7080205@bagra.net.mk> <20030825154829.B20096@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030825154829.B20096@sonic.net>; from dhinds@sonic.net on Mon, Aug 25, 2003 at 03:48:29PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 03:48:29PM -0700, David Hinds wrote:
> I would say that "serial_cs" is more accurate since this is the driver
> for cards that conform to the standard for PCMCIA serial interfaces.
> Renaming to "8250_cs" is obfuscatory and pointlessly breaks config
> files for previous kernel versions.  It is second in foolishness only
> to the genious who thought renaming "ide_cs" to "ide-cs" was a good
> idea.

Yep, and I've also said that I intend changing it back to serial_cs.
I just haven't gotten around to it yet.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

