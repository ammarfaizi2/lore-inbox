Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVHIJSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVHIJSs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVHIJSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:18:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50960 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932478AbVHIJSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:18:47 -0400
Date: Tue, 9 Aug 2005 10:18:42 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dag Bakke <dag@bakke.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Enabling PCMCIA serial ports without pcmciautils/pcmcia_cs in 2.6?
Message-ID: <20050809101842.B4026@flint.arm.linux.org.uk>
Mail-Followup-To: Dag Bakke <dag@bakke.com>, linux-kernel@vger.kernel.org
References: <42F8715C.4000404@bakke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42F8715C.4000404@bakke.com>; from dag@bakke.com on Tue, Aug 09, 2005 at 11:03:24AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 11:03:24AM +0200, Dag Bakke wrote:
> Is this really necessary? I'd guess that serial cards are some of the 
> simpler pcmcia targets to enable? (I could be very wrong..)
> Anyone got an idea about alternative solutions, or can state the minimum 
> binaries/files I need to enable this card? (Advantech COMpad-32/85B-4)

Have you tried just running up a really recent kernel (eg, 2.6.13-rc6)
with PCMCIA and serial (including PCMCIA serial support) built in,
plugging the card in, and seeing what happens?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
