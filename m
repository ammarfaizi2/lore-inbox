Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSA3RxG>; Wed, 30 Jan 2002 12:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290271AbSA3Rv3>; Wed, 30 Jan 2002 12:51:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26131 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290267AbSA3Ru4>; Wed, 30 Jan 2002 12:50:56 -0500
Subject: Re: PROBLEM: Memory
To: michael.may@tnt.de
Date: Wed, 30 Jan 2002 18:03:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200201301648.g0UGmtj32611@pcchk.intra.tnt.de> from "Michael May" at Jan 30, 2002 05:48:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Vz5J-0007xU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think there is a little Problem with Kernel 2.4.17-pre4 - pre7
> 
> When the machine in up for longer than 2 days and is under higher load, the processes will killed, with some syslog-messages: 
> 
> kernel: Out of memory: Killed process <pid>
> 
> I don't know what the Problem is, and all machines where it is, are SMP-Machines on i386.

If you use the rmap patches this one seems to go away. The 2.4.17 vm is still
not quite perfect for all cases. 
