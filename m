Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276337AbRI1WBM>; Fri, 28 Sep 2001 18:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276335AbRI1WBJ>; Fri, 28 Sep 2001 18:01:09 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:55182 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S276336AbRI1WAI>; Fri, 28 Sep 2001 18:00:08 -0400
Date: Fri, 28 Sep 2001 23:00:34 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Tools better than vmstat [was: 2.4.9-ac16 good perfomer?]
Message-ID: <20010928230034.F15457@flint.arm.linux.org.uk>
In-Reply-To: <200109281826.f8SIQLP06585@deathstar.prodigy.com> <Pine.LNX.4.33L.0109281535220.26495-100000@duckman.distro.conectiva> <20010928123455.B8222@mikef-linux.matchmail.com> <20010928210453.B15457@flint.arm.linux.org.uk> <20010928145324.A14801@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010928145324.A14801@mikef-linux.matchmail.com>; from mfedyk@matchmail.com on Fri, Sep 28, 2001 at 02:53:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 02:53:24PM -0700, Mike Fedyk wrote:
> Is there any possibility of using Russell's patch for this user space tool?

There is one property the kernel space method has over any user space
tool on a UP machine (and conceivably a SMP machine with more code) -
you get a complete atomic snapshot of the VM state.  Might be useful
and important, but might not be.

It would be pretty easy to change my kernel patch to produce what you're
requesting, from another sysrq key combination.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

