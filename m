Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271207AbRHZBIS>; Sat, 25 Aug 2001 21:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271208AbRHZBII>; Sat, 25 Aug 2001 21:08:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59660 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271207AbRHZBHw>; Sat, 25 Aug 2001 21:07:52 -0400
Subject: Re: IDE drive won't come back after power down
To: andre@aslab.com (Andre Hedrick)
Date: Sun, 26 Aug 2001 02:10:15 +0100 (BST)
Cc: RossBoylan@stanfordalumni.org (Ross Boylan), sfr@canb.auug.org.au,
        andre@suse.com (Andre Hedrick), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10108251714480.10127-100000@master.linux-ide.org> from "Andre Hedrick" at Aug 25, 2001 05:24:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15aoRL-0008V0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is that the requirements of ACPI is to have a

My PC110 does the same as Ross' machine, and like this box it has no ACPI.
This isnt an ACPI problem on the boxes I've seen do it.

> You can attempt the noisy reset additions to some versions of hdparm, and
> then issuing the the checkpower commands until staus is reported as ready,

Any reason you cant do that in kernel space, if an app can do it then
pm thread code can do it ...

Alan

