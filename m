Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269939AbRHJQJV>; Fri, 10 Aug 2001 12:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269940AbRHJQJL>; Fri, 10 Aug 2001 12:09:11 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:1723 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S269939AbRHJQJA>; Fri, 10 Aug 2001 12:09:00 -0400
Date: Fri, 10 Aug 2001 17:09:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: Caleb Tennis <caleb@aei-tech.com>, linux-kernel@vger.kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH] serial.c to support ConnectTech Blueheat PCI
Message-ID: <20010810170910.E27072@flint.arm.linux.org.uk>
In-Reply-To: <01081010190800.03758@pete.aei-tech.com> <017801c121b5$e254f3e0$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <017801c121b5$e254f3e0$294b82ce@connecttech.com>; from stuartm@connecttech.com on Fri, Aug 10, 2001 at 12:02:41PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2001 at 12:02:41PM -0400, Stuart MacDonald wrote:
> This patch is maintained by me; it applies to 5.05. I'm not sure how
> 5.05[abc] are different from vanilla 5.05 though.

I'm maintaining a new serial driver structure in CVS at:

	:pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot
	(no password)

	module: serial

There's a couple of outstanding bits in my working set left to commit,
but all the code (minus makefiles and Configure scripts) is there.
If you'd like to port it to the new version cleanly, then I'll keep
it in there.

Note that Ted hasn't given his OK for this restructuring - he's too
busy to even look and comment at the moment.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

