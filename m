Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313122AbSEVMqI>; Wed, 22 May 2002 08:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313157AbSEVMqH>; Wed, 22 May 2002 08:46:07 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62991 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313122AbSEVMqF>; Wed, 22 May 2002 08:46:05 -0400
Subject: Re: Linux-2.5.17
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 22 May 2002 14:06:00 +0100 (BST)
Cc: jack@suse.cz, torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3CEB78D7.7070107@evision-ventures.com> from "Martin Dalecki" at May 22, 2002 12:54:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AVoW-0001Yl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please put the following crap under /proc/sys/fs,
> where it belongs. OK?
> 
> [root@kozaczek fs]# pwd
> /proc/fs
> [root@kozaczek fs]# cat quota
> Version 60501
> Formats
> 0 0 0 0 0 0 0 8
> [root@kozaczek fs]#
> 
> Or are are you going to reinvent just enother
> case of /proc/ formatting compatibility problems?!
> And the requirement to have /proc mounted for quoate usage?!

/proc/sys/ is sysctl space. 

	/proc/sys/fs/quota/version
	/proc/sys/fs/quota/format/0,1,2,3..

maybe

> (PS. Hah! I found finally someone today who deserves flames! :-).)

You looked in the mirror ?
