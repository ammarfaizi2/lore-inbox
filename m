Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292943AbSCDWcp>; Mon, 4 Mar 2002 17:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292948AbSCDWcf>; Mon, 4 Mar 2002 17:32:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39179 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292943AbSCDWcW>; Mon, 4 Mar 2002 17:32:22 -0500
Subject: Re: Need Suggestion(modifying kernel source)
To: cvaka_kernel@yahoo.com (chiranjeevi vaka)
Date: Mon, 4 Mar 2002 22:47:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020304212315.89890.qmail@web21305.mail.yahoo.com> from "chiranjeevi vaka" at Mar 04, 2002 01:23:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16i1F0-0000sC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The major problem I am getting is, as and when I do a
> small change, to test that change, I have to compile
> the whole kernel make boot floppy and reboot the
> kernel with that floppy and test the code. This way is
> takinbg too much time. I donno how linux kernel
> developers will make changes to kernel and test them. 

Tweak the file concerned , make bzImage make modules
On the target box with the other machine NFS mounted
make modules_install; cp the kernel and reboot the
test box

> Can you suggest me in this issue. If it is any thing
> to deal with the kernel debugger can you give me
> proper links so that I can get more information about
> that.

Search for "kdb" "linux"

Also look at usermode linux (on sourceforge), then you can run a Linux
inside of Linux
