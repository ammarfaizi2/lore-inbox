Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319659AbSH3Ts0>; Fri, 30 Aug 2002 15:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319662AbSH3Ts0>; Fri, 30 Aug 2002 15:48:26 -0400
Received: from mz01.hal9001.net ([80.16.61.154]:51340 "EHLO server.hal9001.net")
	by vger.kernel.org with ESMTP id <S319659AbSH3Ts0>;
	Fri, 30 Aug 2002 15:48:26 -0400
Message-ID: <3D6FCCAC.E00585A5@hal9001.net>
Date: Fri, 30 Aug 2002 21:51:08 +0200
From: Stefano Biella <sbiella@hal9001.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Egli <dan@shortcircuit.dyndns.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel panic: no init found with 2.5.32
References: <3D6FC85D.67286B32@hal9001.net> <001701c2505c$e32ebea0$9600a8c0@yamatto>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Egli wrote:
> 
> What are you passing as the init= arg? What is your boot manager? (Grub?
> Lilo? 3rd Party?)

the boot manager is Lilo 22.2

my lilo.conf is:
-----------------
boot= /dev/hda
image = /boot/vmlinuz
  root = /dev/hda2
  label = Linux
  read-only
-----------------

> no init means that when the kernel boot sequence tries to spawn off
> /sbin/init, it cannot find the file.The fault could be any one of multiple.

I don't know why with 2.4.xx works fine and with 2.5.xx make a kernel
panic...

