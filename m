Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277253AbRJLG0m>; Fri, 12 Oct 2001 02:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277252AbRJLG0c>; Fri, 12 Oct 2001 02:26:32 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:62986 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S277247AbRJLG0T>;
	Fri, 12 Oct 2001 02:26:19 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15302.35510.947325.295210@cargo.ozlabs.ibm.com>
Date: Fri, 12 Oct 2001 16:16:22 +1000 (EST)
To: "Christopher Friesen" <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: so, no way to kill process? have to reboot?
In-Reply-To: <3BC6097F.79B6E2D1@nortelnetworks.com>
In-Reply-To: <3BC6097F.79B6E2D1@nortelnetworks.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen writes:

> Well, the unkillable process continues on.  Does nobody else have any ideas on
> how to kill an unkillable process in the R state thats sucking up all my unused
> cpu cycles?

I would suspect that it is actually looping inside the kernel, which
would mean that there indeed was no way to kill it.  You could try
alt-scrolllock on the console and see if you get a register dump of
it, or maybe one of the alt-sysrq magic keys might give you some
information.  But I suspect that rebooting is ultimately going to be
your only solution.

Paul.

