Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267374AbTBNUYa>; Fri, 14 Feb 2003 15:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267423AbTBNUY3>; Fri, 14 Feb 2003 15:24:29 -0500
Received: from [81.2.122.30] ([81.2.122.30]:57607 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267374AbTBNUY2>;
	Fri, 14 Feb 2003 15:24:28 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302142035.h1EKZLXc001121@darkstar.example.net>
Subject: Re: RFC/CFT 1/1: SIGWINCH - behaviour change
To: rmk@arm.linux.org.uk (Russell King)
Date: Fri, 14 Feb 2003 20:35:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030214202110.G14659@flint.arm.linux.org.uk> from "Russell King" at Feb 14, 2003 08:21:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I keep on tripping over an annoying "feature" of our tty layer - if
> you have a session running with multiple jobs (eg, three ssh sessions)
> and you resize the window, SIGWINCH is only sent to the foreground
> process, be it the shell, or one of the ssh sessions.

This reminds me of a problem I had, which I'd forgotten about, maybe
it's related:

I was using a 7N1, (that's not a typo, it really was 7N1), 9600 bps
serial terminal, and from the shell prompt I connected to a remote
machine using 8N1.  I logged in successfully, but the shell didn't
work, yet setting the local serial terminal to 8N1 made it work (!).
After logging out from the remote machine, I had to set the serial
terminal back to 7N1 to use the local machine.

Can anybody else reproduce this?  My serial terminal is currently out
of service, (needs some wires soldered on a DB9 connector :-) ).

John.
