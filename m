Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131221AbQLFBx7>; Tue, 5 Dec 2000 20:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbQLFBxt>; Tue, 5 Dec 2000 20:53:49 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10500 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130756AbQLFBxf>; Tue, 5 Dec 2000 20:53:35 -0500
Subject: Re: That horrible hack from hell called A20
To: hpa@transmeta.com (H. Peter Anvin)
Date: Wed, 6 Dec 2000 01:25:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        torvalds@transmeta.com (Linus Torvalds), kai@thphy.uni-duesseldorf.de
In-Reply-To: <3A2D7AA4.9E7D414F@transmeta.com> from "H. Peter Anvin" at Dec 05, 2000 03:30:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E143TKU-0000AS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Okay, here is my latest attempt to find a way to toggle A20M# that
> genuinely works on all machines -- including Olivettis, IBM Aptivas,
> bizarre notebooks, yadda yadda.

Can I suggest a slightly different hammer. Flip the A20 via the keyboard
controller and set the timeout to say 1 second. If that fails then kick the
0x92 stuff ?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
