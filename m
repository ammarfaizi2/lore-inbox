Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbSJ2ISa>; Tue, 29 Oct 2002 03:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbSJ2ISa>; Tue, 29 Oct 2002 03:18:30 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1809 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261683AbSJ2IS3>; Tue, 29 Oct 2002 03:18:29 -0500
Date: Tue, 29 Oct 2002 08:24:49 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: DevilKin <devilkin-lkml@blindguardian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.44] 8250_cs does not work.
Message-ID: <20021029082449.A17852@flint.arm.linux.org.uk>
Mail-Followup-To: DevilKin <devilkin-lkml@blindguardian.org>,
	linux-kernel@vger.kernel.org
References: <200210290908.49320.devilkin-lkml@blindguardian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210290908.49320.devilkin-lkml@blindguardian.org>; from devilkin-lkml@blindguardian.org on Tue, Oct 29, 2002 at 09:08:49AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 09:08:49AM +0100, DevilKin wrote:
> Since I've started to test the 2.5 series, I've noticed that 8250_cs doesn't 
> really work - it doesn't detect my pcmcia card (psion global gold card).
> 
> I had a patch for 2.5.40 from Russell King that fixed it, but I can't get it 
> to apply to 2.5.44, and well - out of the box it still doesn't work.
> 
> Is there any plan to get that fix in the kernel?

The fix went in, so something else must have broken it.  There were some
changes to the PCMCIA layer resource handling.  Please supply:

1. kernel messages
2. cardmgr-related messages from /var/log/messages
3. /proc/ioports
4. /proc/tty/driver/serial

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

