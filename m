Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131741AbRCUTS5>; Wed, 21 Mar 2001 14:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131737AbRCUTSh>; Wed, 21 Mar 2001 14:18:37 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42256 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131742AbRCUTRc>; Wed, 21 Mar 2001 14:17:32 -0500
Subject: Re: How to mount /proc/sys/fs/binfmt_misc ?
To: richard.guenther@student.uni-tuebingen.de (Richard Guenther)
Date: Wed, 21 Mar 2001 19:18:29 +0000 (GMT)
Cc: viro@math.psu.edu (Alexander Viro), Wayne.Brown@altec.com,
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <Pine.LNX.4.30.0103161847470.517-100000@fs1.dekanat.physik.uni-tuebingen.de> from "Richard Guenther" at Mar 16, 2001 06:49:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14fo7s-0000yU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	a) mount it on some real place. And write there to register
> > entries instead of the bogus /proc/sys/fs/binfmt_misc
> > 	b) add a couple of proc_mkdir() into fs/proc/root.c
> c) stick with the previous binfmt_misc in 2.4 and leave the
>    filesystem with 2.5

Actually you would still need the other fixes otherwise you might as well put
the root password in /etc/motd
