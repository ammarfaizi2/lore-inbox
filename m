Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129825AbRAEVFL>; Fri, 5 Jan 2001 16:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRAEVFB>; Fri, 5 Jan 2001 16:05:01 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8712 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129798AbRAEVEv>; Fri, 5 Jan 2001 16:04:51 -0500
Subject: Re: X and 2.4.0 problem (video bios probing?)
To: kevin@scrye.com (Kevin Fenzi)
Date: Fri, 5 Jan 2001 21:06:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010105210016.1778.qmail@scrye.com> from "Kevin Fenzi" at Jan 05, 2001 02:00:16 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Ee3z-0008R6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (II) Loading /usr/X11R6/lib/modules/linux/libint10.a
> (II) Module int10: vendor="The XFree86 Project"
>         compiled for 4.0.1a, module version = 1.0.0
>         ABI class: XFree86 Video Driver, version 0.2
> (EE) ATI(0): Unable to initialise int10 interface.

Thats the critical bit but it isnt directly a kernel thing. Im not sure
why it should have failed. Do you have different .config options (eg ATI fb
options ?)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
