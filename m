Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278709AbRKFKPz>; Tue, 6 Nov 2001 05:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278722AbRKFKPp>; Tue, 6 Nov 2001 05:15:45 -0500
Received: from [212.18.232.186] ([212.18.232.186]:14866 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S278709AbRKFKP2>; Tue, 6 Nov 2001 05:15:28 -0500
Date: Tue, 6 Nov 2001 10:15:18 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Serial port maintainance ?
Message-ID: <20011106101518.A9169@flint.arm.linux.org.uk>
In-Reply-To: <20011105180821.A12927@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011105180821.A12927@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Mon, Nov 05, 2001 at 06:08:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 06:08:21PM -0800, Jean Tourrilhes wrote:
> 	Well... What next ?

Send it to me, and/or check out the CVS at:

	:pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot
	(no password)
	module: serial

The serial CVS contains both the kernel uart-based serial driver(s), and
a copy of setserial utility to match.

$ cvs -d :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot login
$ cvs -d :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot co serial

This new serial driver is scheduled for inclusion into the 2.5 kernel
series, totally replacing the original serial.c.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

