Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129792AbQK0PUq>; Mon, 27 Nov 2000 10:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131173AbQK0PUg>; Mon, 27 Nov 2000 10:20:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28526 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129792AbQK0PUS>; Mon, 27 Nov 2000 10:20:18 -0500
Subject: Re: KERNEL BUG: console not working in linux
To: g.anzolin@inwind.it (Gianluca Anzolin)
Date: Mon, 27 Nov 2000 14:50:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001127150543.A3083@dracula.home.intranet> from "Gianluca Anzolin" at Nov 27, 2000 03:05:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E140Pc3-0003AI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         inb     $0x92, %al                      #
>         orb     $02, %al                        # "fast	A20" version
>         outb    %al, $0x92			# some chips have only this
> 
> Then my system worked without problems.
> 
> Now what I ask is:
> 1) Why did they disable my videocard ?

Because your machine is not properly PC compatible

> 2) Whate are they supposed to do?

They switch on the A20 line


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
