Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261906AbSJNJIf>; Mon, 14 Oct 2002 05:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261947AbSJNJIf>; Mon, 14 Oct 2002 05:08:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46861 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261906AbSJNJIe>; Mon, 14 Oct 2002 05:08:34 -0400
Date: Mon, 14 Oct 2002 10:14:25 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Romain Lievin <rlievin@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serial API ('serport' ?)
Message-ID: <20021014101425.A32186@flint.arm.linux.org.uk>
References: <20021014090755.GB2911@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021014090755.GB2911@free.fr>; from rlievin@free.fr on Mon, Oct 14, 2002 at 11:07:55AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 11:07:55AM +0200, Romain Lievin wrote:
> I would like to know whether a kind of parport exists for the serial ports.

Not currently.

> This will allow me to do some low level accesses on the serial port pins
> (CTS/RTS & DSR/DTR). I need to implement a bit-banging access on the serial
> port which can coexist with the other serial ports.

Although these are available to user space, they're not easily controlled
from anything outside the serial driver at the moment.  I'm aware of this
limitation, and it needs to be fixed; there are keyboards (eg) for the iPAQ
that need to bitbang these signals.

Unfortunately that doesn't help you.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

