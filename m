Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279814AbRKAWP3>; Thu, 1 Nov 2001 17:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279813AbRKAWPT>; Thu, 1 Nov 2001 17:15:19 -0500
Received: from smtp.mailbox.co.uk ([195.82.125.32]:18338 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S279812AbRKAWO7>; Thu, 1 Nov 2001 17:14:59 -0500
Date: Thu, 1 Nov 2001 22:14:57 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Tim Waugh <twaugh@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: driver initialisation order problem
Message-ID: <20011101221457.F10819@flint.arm.linux.org.uk>
In-Reply-To: <20011101202846.E10819@flint.arm.linux.org.uk> <Pine.LNX.4.10.10111011324360.2293-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10111011324360.2293-100000@transvirtual.com>; from jsimmons@transvirtual.com on Thu, Nov 01, 2001 at 01:25:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 01:25:06PM -0800, James Simmons wrote:
> Better yet we both need important changes to the serial layer. 

My priority as far as serial stuff goes is to keep what we now have
stable so that the people who _need_ to use it (those in the ARM world)
have a chance of stability.

This doesn mean that the input stuff as far as the serial side is
concerned, and the other changes to integrate some parts of the
serial layer into the tty layer as suggested by Ted will have to
hold off for a while as the current implementation matures and
stabilises.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

