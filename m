Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSBUT2V>; Thu, 21 Feb 2002 14:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292732AbSBUT2L>; Thu, 21 Feb 2002 14:28:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3849 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292730AbSBUT2D>; Thu, 21 Feb 2002 14:28:03 -0500
Subject: Re: RH7.2 running 2.4.9-21-SMP (dual Xeon's) yields "Illegal
To: tepperly@llnl.gov (Tom Epperly)
Date: Thu, 21 Feb 2002 19:41:54 +0000 (GMT)
Cc: arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202211118030.19681-100000@tux06.llnl.gov> from "Tom Epperly" at Feb 21, 2002 11:23:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dz6I-0007za-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> NVdriver in the running system.  Will the kernel load NVdriver if the X11
> server is never started after a reboot?  /etc/modules.conf has this line

Shouldn't do

> alias char-major-195 NVdriver

Change to 

alias char-major-195 off

and it should be fine
