Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261283AbSJLQgz>; Sat, 12 Oct 2002 12:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261286AbSJLQgz>; Sat, 12 Oct 2002 12:36:55 -0400
Received: from 62-190-217-29.pdu.pipex.net ([62.190.217.29]:30987 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261283AbSJLQgx>; Sat, 12 Oct 2002 12:36:53 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210121651.g9CGpdXM010784@darkstar.example.net>
Subject: Re: 2.5 Problem Report Status
To: tmolina@cox.net (Thomas Molina)
Date: Sat, 12 Oct 2002 17:51:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210120758420.4532-100000@dad.molina> from "Thomas Molina" at Oct 12, 2002 10:38:21 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                                2.5 Kernel Problem Reports as of 12 Oct
> 
>    Status                 Discussion  Problem Title
> --------------------------------------------------------------------------
>    open                   05 Oct 2002 2.5.x and 8250 UART problems
> 
>   22. http://marc.theaimsgroup.com/?l=linux-kernel&m=103383019409525&w=2
> 
> --------------------------------------------------------------------------

2.5.41 didn't boot on the test machine.
2.5.42 does boot on the test machine, and exhibits the same problems

Typical scenario:

MMX-200 with plenty of RAM (128 MB), and a 16550A UART running 2.5.40

doing a 9600 bps Z-Modem transfer to

486 SX-20 with 4 MB RAM, and a 8250 UART, running 2.5.42

>From time to time, (every 4-8K or so), the Z-Modem protocol will
detect an error, and re-send blocks.

This does not occur with 2.2.13 or 2.2.21 on the 486.

Usually the errors occur at the same time as hard disk accesses, but
turning on IRQ unmasking does not prevent them.  Also, sometimes the
hard disk is accessed, and no error occurs.

John.
