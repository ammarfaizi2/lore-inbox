Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSGFVJb>; Sat, 6 Jul 2002 17:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSGFVJb>; Sat, 6 Jul 2002 17:09:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19210 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313070AbSGFVJa>; Sat, 6 Jul 2002 17:09:30 -0400
Date: Sat, 6 Jul 2002 22:12:05 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andreas Schwab <schwab@suse.de>
Cc: =?iso-8859-1?Q?Witek_Kr=EAcicki?= <adasi@kernel.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] /proc/cpuinfo output from some arch
Message-ID: <20020706221205.A5242@flint.arm.linux.org.uk>
References: <003201c224cd$e25df820$0201a8c0@witek> <jen0t4g35k.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <jen0t4g35k.fsf@sykes.suse.de>; from schwab@suse.de on Sat, Jul 06, 2002 at 07:46:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2002 at 07:46:47PM +0200, Andreas Schwab wrote:
> Processor	: Intel StrongARM-110 rev 4 (v4l)

Note that this could also be something like:

Processor	: ARM/VLSI Arm1020id(wb)BRR rev 1 (v4)

or:

Processor	: ARM ARM926EJ-Sid(wb)RR rev 2 (v5)

It might change further if the manufacturer decides to have a space
in their name.  Basically, /proc/cpuinfo was never meant to be passed
by programs, and its not something I'd like to support with the current
format.
 
-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

