Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129660AbRBCSJj>; Sat, 3 Feb 2001 13:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129759AbRBCSJ3>; Sat, 3 Feb 2001 13:09:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43531 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129660AbRBCSJS>; Sat, 3 Feb 2001 13:09:18 -0500
Subject: Re: low memory
To: javiroman@wanadoo.es (Javi Roman)
Date: Sat, 3 Feb 2001 18:10:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A7C485F.15BC3FF9@wanadoo.es> from "Javi Roman" at Feb 03, 2001 07:05:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14P78i-0000BW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - kernel image (2.2.5-15) : 301 KB (I can`t make it smaller).
> 
> "install" program executes "mke2fs /dev/hda1" where /dev/hda1 partition
> has 500MB.
> So in the step: "Writing inode tables: 6/63" the system hang.

Known problem with older 2.2 kernels. There are some VM things involved where
it fails to make progress and hangs. Its also occasionally seen in installers
with older 2.2

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
