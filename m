Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132670AbRDCWnb>; Tue, 3 Apr 2001 18:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132678AbRDCWnU>; Tue, 3 Apr 2001 18:43:20 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:30960
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S132670AbRDCWnF>; Tue, 3 Apr 2001 18:43:05 -0400
Date: Tue, 3 Apr 2001 15:38:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.3 and SysRq over serial console
Message-ID: <20010403153820.A7610@opus.bloom.county>
In-Reply-To: <20010331163808.A9740@opus.bloom.county> <20010403210744.A22460@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010403210744.A22460@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, Apr 03, 2001 at 09:07:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2001 at 09:07:44PM +0100, Russell King wrote:
> On Sat, Mar 31, 2001 at 04:38:08PM -0700, Tom Rini wrote:
> > Hello all.  Without the attached patch, SysRq doesn't work over a serial
> > console here.  Has anyone else seen this problem?
> 
> It is handled at the serial port driver level, not the tty level.  You need
> to turn on CONFIG_SERIAL_CONSOLE and CONFIG_MAGIC_SYSRQ, and issue a break
> followed by the relevent character within 5 seconds on the serial TTY being
> used as the kernel console.

That wasn't working here however.  Unless minicom isn't sending the proper
break.  Doing the keycombo which slips my mind to send a break, followed by
'h' in minicom does nothing.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
