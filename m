Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbSLLNHp>; Thu, 12 Dec 2002 08:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbSLLNHo>; Thu, 12 Dec 2002 08:07:44 -0500
Received: from comtv.ru ([217.10.32.4]:53401 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S263899AbSLLNHo>;
	Thu, 12 Dec 2002 08:07:44 -0500
X-Comment-To: Stefan Reinauer
To: Stefan Reinauer <stepan@suse.de>
Cc: Matt Young <wz6b@arrl.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: grub and 2.5.50
References: <200212091640.35716.wz6b@arrl.net>
	<20021211134322.GA23761@suse.de>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 12 Dec 2002 16:09:09 +0300
In-Reply-To: <20021211134322.GA23761@suse.de>
Message-ID: <m3wumfz8ne.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Stefan Reinauer (SR) writes:

 SR> * Matt Young <wz6b@arrl.net> [021210 01:40]:
 >> These grub commands work with SUSE 2.4.19-4GB:
 >> 
 >> kernel (hd0,0)/bzImage root=/dev/hda3 vga=791 initrd
 >> (hd0,0)/initrd
 >> 
 >> But with 2.5.50 the kernel panics after Freeing the initrd memory
 >> with "Unable te mount root FS, please correct the root= cammand
 >> line"

 >> I have compiled with the required file systems
 >> (EXT2,EXT3,REISERFS).

 SR> Did you also compile in support for the root device itself
 SR> (i.e. ide or scsi driver). These are loaded via the initrd
 SR> normally on SuSE, which will not work, if you did not install
 SR> newer modutils..

First of all, 2.5.10 has sysfs-related bug. try to replace root=/dev/hda3
by root=303

