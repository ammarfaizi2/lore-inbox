Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131141AbRCJTcQ>; Sat, 10 Mar 2001 14:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131142AbRCJTcG>; Sat, 10 Mar 2001 14:32:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20489 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131141AbRCJTbs>; Sat, 10 Mar 2001 14:31:48 -0500
Subject: Re: Kernel 2.4.1 on RHL 6.2
To: miquels@cistron-office.nl (Miquel van Smoorenburg)
Date: Sat, 10 Mar 2001 19:34:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <98drnp$qq0$1@ncc1701.cistron.net> from "Miquel van Smoorenburg" at Mar 10, 2001 06:28:09 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14bp8D-0007Fq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >asm -> /usr/src/linux/include/asm-i386/
> >linux -> /usr/src/linux/include/linux/
> 
> Note! You only have to have those symlinks on broken systems such
> as Redhat.

< 7.0. 

On RH 6.x you should have a set of 2.2 header includes at /usr/src/linux as
required by the dependancies RPM uses.  (kernel-headers package).

7.0 or higher keeps the glibc includes out of /usr/src


