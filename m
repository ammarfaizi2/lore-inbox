Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312119AbSDDXyb>; Thu, 4 Apr 2002 18:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312136AbSDDXyV>; Thu, 4 Apr 2002 18:54:21 -0500
Received: from hitchcock.mail.mindspring.net ([207.69.200.23]:46866 "EHLO
	hitchcock.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S312119AbSDDXyM>; Thu, 4 Apr 2002 18:54:12 -0500
Date: Thu, 04 Apr 2002 18:54:07 -0500
From: <joeja@mindspring.com>
To: linux-kernel@vger.kernel.org
Reply-To: joeja@mindspring.com
Subject: faster boots?
Message-ID: <Springmail.0994.1017964447.0.72656900@webmail.atl.earthlink.net>
X-Originating-IP: 4.20.162.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
    Is there some way of making the linux kernel boot faster?  

    While I know that many people here probably don't reboot there machines often, I live in CA where my electrictiy is still high and see no reason to keep a machine on that is not in use (i.e. while I sleep or am at work).  
  
    I tested freebsd on an old P133Mhz/32Meg ram and it booted faster with the GENERIC kernel than linux did on a AMD 1200Mhz/512Meg ram, which seemed odd.  Linux on that same P133 box also took longer than FreeBSD to boot.  

    If I have a machine that does not change from day to day hardware wise why when I boot the thing do I need to probe the hardware again and again each time?  Would passing more options on the command line help like all the addresses and IRQ's of known hardware?
    Wouldn't it make sense to store this data on the files system? Certainly if something like grub or lilo can figure out how to access a file on the drive the kernel could check for a 'defaults' file or something to get the default irq's, hardware, interrupts, etc from.  Then the kernel could probe these first and if the probe fails proble elsewhere for the device.

  Or is there another way of speeding up the linux kernel boot process?

Joe










