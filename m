Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129198AbRBGJYh>; Wed, 7 Feb 2001 04:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130113AbRBGJY1>; Wed, 7 Feb 2001 04:24:27 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9490 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129198AbRBGJYI>; Wed, 7 Feb 2001 04:24:08 -0500
Subject: Re: Problems with Linux 2.4.1
To: zvyagin@gamspc7.ihep.su (Alexander Zvyagin)
Date: Wed, 7 Feb 2001 09:24:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0102070207300.1226-500000@gamspc7.ihep.su> from "Alexander Zvyagin" at Feb 07, 2001 02:27:57 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14QQqC-0008Ca-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2) Frame-buffer mode does not work with my video card SiS630.
>    But ok, frame-buffer mode is EXPERIMENTAL in linux.
>    Computer boots, but screen is blank. All messages are fine. 

You might want to try -ac that has specific rather than vesafb support
for the SIS framebuffers.

> 4) Sometimes computer hangs up. It does not happen too often
>    (it happend 2 times), but I am curious why? There is no OOPS, and log
>    files do not have any error messages... And I can not reproduce this
>    bug.

2.4.1 has plenty of bugs, and it seems a lot of them show up best on sis
hardware 8(
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
