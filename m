Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262488AbSJETyW>; Sat, 5 Oct 2002 15:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262525AbSJETyW>; Sat, 5 Oct 2002 15:54:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5387 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262488AbSJETyV>; Sat, 5 Oct 2002 15:54:21 -0400
Date: Sat, 5 Oct 2002 20:59:54 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: jbradford@dial.pipex.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.x and 8250 UART problems
Message-ID: <20021005205954.A1682@flint.arm.linux.org.uk>
References: <200210051506.g95F6jfL000423@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210051506.g95F6jfL000423@darkstar.example.net>; from jbradford@dial.pipex.com on Sat, Oct 05, 2002 at 04:06:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 04:06:45PM +0100, jbradford@dial.pipex.com wrote:
> The 486 SX-20 with 4 MB RAM, running 2.2.21 reliably achieves about 650
> BPS download from another machine, with the port runnnig at 9600 bps.
> With 2.5.40, many characters are lost at 9600, making, e.g. a ZModem
> transfer retry for almost every block.

Ok, we need to find out where stuff is getting dropped.  Dumping
/proc/tty/driver/serial is always a good idea when reporting anything
like this.

The important thing is the change in the counters.  Can you supply the
port in question both before and after the zmodem run please?

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

