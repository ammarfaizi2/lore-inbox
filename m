Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292971AbSCIWX4>; Sat, 9 Mar 2002 17:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292970AbSCIWXh>; Sat, 9 Mar 2002 17:23:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34826 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292971AbSCIWXS>; Sat, 9 Mar 2002 17:23:18 -0500
Subject: Re: loading ./cryptfs.o will taint the kernel
To: brian@worldcontrol.com
Date: Sat, 9 Mar 2002 22:38:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020309221341.GA2533@top.worldcontrol.com> from "brian@worldcontrol.com" at Mar 09, 2002 02:13:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jpTp-0002jM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> loading ./cryptfs.o will taint the kernel: non-GPL license - LGPL
> 
> I have long thought that I understood the reasoning behind "taint" and
> binary drivers.
> 
> However, cryptfs is available with complete source code, so I presume
> the "undebug-able" argument doesn't apply.
> 
> So what is the big deal?

Sounds like someone put the wrong MODULE_LICENSE() tag on it. An LGPL item
combined with a GPL work gives you a GPL result (see the LGPL notes on the
matter). So the kernel module tag ought to be GPL
