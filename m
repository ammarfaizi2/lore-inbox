Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265413AbSLMVOA>; Fri, 13 Dec 2002 16:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbSLMVOA>; Fri, 13 Dec 2002 16:14:00 -0500
Received: from [208.48.139.185] ([208.48.139.185]:3718 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S265413AbSLMVN7>; Fri, 13 Dec 2002 16:13:59 -0500
Date: Fri, 13 Dec 2002 13:21:44 -0800
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Serial Console Problem
Message-ID: <20021213132144.A4513@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if this is quite on topic for linux-kernel but I couldn't find
answers anywhere else so here goes:

I've got a couple systems where I've configured ttyS0 as a serial
console.  Everything works fine when a cable is plugged in and a
terminal is listening on the other side.  The kernel in question is
2.4.20.
  
However, unplugging the cable and rebooting results in the boot process
hanging.  It appears that the kernel is waiting for the serial port
acknoledge the fact that it is writing data.
  
What's strange is that this is a problem on one machine, but doesn't
appear to be a problem on another.
  
Anyone have any ideas on how to work around this issue besides leaving a
terminal hooked up all the time?

-Dave
