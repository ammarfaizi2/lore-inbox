Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262831AbRE0RXJ>; Sun, 27 May 2001 13:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262832AbRE0RW7>; Sun, 27 May 2001 13:22:59 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53516 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262831AbRE0RWt>; Sun, 27 May 2001 13:22:49 -0400
Subject: Re: Problems with ac12 kernels and up
To: jcwren@jcwren.com
Date: Sun, 27 May 2001 18:20:04 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <NDBBKBJHGFJMEMHPOPEGAEEACHAA.jcwren@jcwren.com> from "John Chris Wren" at May 27, 2001 10:44:49 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1544Cy-00027I-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Checking root filesystem. /dev/hde13 is mounted.
> Cannot continue, aboorting.
> *** An error occurred during the file system check.
> *** Dropping you to a shell; the system will reboot
> *** when you leave the shell.

That means the file system was mounted read/write at boot time. That normally
indicates a lilo misconfiguration however your lilo.conf looks 
correct.

Alan

