Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130647AbRCITnM>; Fri, 9 Mar 2001 14:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130650AbRCITmx>; Fri, 9 Mar 2001 14:42:53 -0500
Received: from frankffm10-40.bunt.com ([195.178.8.165]:39940 "HELO
	dragon.flyn.org") by vger.kernel.org with SMTP id <S130512AbRCITmd>;
	Fri, 9 Mar 2001 14:42:33 -0500
Date: Fri, 9 Mar 2001 15:40:32 -0500
From: "W. Michael Petullo" <mike@flyn.org>
To: linux-kernel@vger.kernel.org
Subject: broken(?) Lucent Venus chipset and Linux 2.4
Message-ID: <20010309154032.A1154@dragon.flyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux dragon.flyn.org 2.4.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Lucent Microelectronics Venus based modem, the Actiontec
Internal Call Waiting modem.  I have been trying to get it working well
with Linux 2.4 for some time now.  Theodore Ts'o, the maintainer of
the Linux serial driver, and I have talked quite a bit on the subject.
We both suspect that the Venus chipset is broken.

I have some code available at http://www.flyn.org related to this issue.
First, I have an ugly patch that adds support for the Actiontec Internal
Call Waiting modem to Theodore's serial driver version 5.05.  Second,
I have a simple kernel module that seems to demonstrate that the Venus
chipset has something wrong with it.  The module code should be self
explanatory.  To summarize, writing a value, call it foo, to, for example,
the modem's interrupt enable register and then immediately reading the
register's value does not always return foo.

If you have or have access to a Linux box with a Venus-based modem,
answering any of these questions would be very helpful:

o Does your modem work flawlessly with Linux 2.4?

o Could you run my test kernel module?  If so, what are the results on
your computer?

I have been lobbying both Lucent and Actiontec to help me with this issue.
Up to this point neither has provided substantial help.  However, there
is promise and I am not ready to give up yet.

Thanks!

-- 
W. Michael Petullo

:wq
