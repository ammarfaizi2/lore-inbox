Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261279AbRELQqT>; Sat, 12 May 2001 12:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261280AbRELQqJ>; Sat, 12 May 2001 12:46:09 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3346 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261279AbRELQpu>; Sat, 12 May 2001 12:45:50 -0400
Subject: Re: Kernel "Oops" output
To: oppaak@alaweb.com (Aubrey Kilpatrick)
Date: Sat, 12 May 2001 17:42:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <B0032926992@gate> from "Aubrey Kilpatrick" at May 12, 2001 09:48:16 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ycTP-0004Js-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> tried to find the "opps" output in the /var/log/messages file but there is
> nothing there.  The system hangs at the last line of the oops output to the
> screen and will not accept any commands.  The only recourse at this point is
> to "CTRL-ALT-DEL" and let the system reboot.
> 
> The oops out follows:
> 
> Power down
> general protection fault: f000
> CPU: 0
> EIP: 005: [<00008865>]

That is a bug in the APM BIOS on your machine. Upgrading to 2.2.19 and 
enabling the real mode bios poweroff might help..
