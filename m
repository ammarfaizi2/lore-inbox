Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265075AbSKFN2f>; Wed, 6 Nov 2002 08:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265078AbSKFN2e>; Wed, 6 Nov 2002 08:28:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:524 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265075AbSKFN2C>; Wed, 6 Nov 2002 08:28:02 -0500
Date: Wed, 6 Nov 2002 13:34:38 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Up silly limit on .config line length
Message-ID: <20021106133438.A4789@flint.arm.linux.org.uk>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org
References: <20021105233844.J24606@flint.arm.linux.org.uk> <Pine.LNX.4.44.0211061425280.6949-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211061425280.6949-100000@serv>; from zippel@linux-m68k.org on Wed, Nov 06, 2002 at 02:32:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 02:32:30PM +0100, Roman Zippel wrote:
> On Tue, 5 Nov 2002, Russell King wrote:
> > I believe that this arbitary limit should be eliminated by some method.
> > However, as a "get you working" patch with a new arbitary limit of 1024
> > characters:
> 
> I was already wondering, how much I should allow. :)
> But I'd rather set an arbitrary limit (and warn) than allowing an 
> arbitrary long string.

That'd also work, but note that stderr/stdout messages are very easily
missed when using menuconfig.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

