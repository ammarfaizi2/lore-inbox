Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310440AbSCPROo>; Sat, 16 Mar 2002 12:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310441AbSCPROd>; Sat, 16 Mar 2002 12:14:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52232 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310440AbSCPROR>; Sat, 16 Mar 2002 12:14:17 -0500
Subject: Re: Linux 2.4.19-pre3-ac1
To: joe@tmsusa.com (J Sloan)
Date: Sat, 16 Mar 2002 17:30:02 +0000 (GMT)
Cc: MrChuoi@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <3C92DF96.6010904@tmsusa.com> from "J Sloan" at Mar 15, 2002 10:00:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mI0I-0006kp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >2.4.19-pre2-ac4: cannot allocate memory
> >2.4.19-pre3-ac1: cannot allocate memory
> >2.4.19-pre2aa*: OK
> 
> I'd bet they are all on the borderline -
> It may be that you are simply exhausting vm.

It may well be borderline but its certainly interesting the rmap vm thinks
it is out of memory first. Whats the overcommitted_AS value just before it
reports that it cannot allocate memory.

I'm also interested to know if it occurs with a lot more swap. It might be
a false report coming from a bug in the vm accounting changes too

