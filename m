Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277380AbRJOKzx>; Mon, 15 Oct 2001 06:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277385AbRJOKzn>; Mon, 15 Oct 2001 06:55:43 -0400
Received: from smtp01.uc3m.es ([163.117.136.121]:34058 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S277380AbRJOKzj>;
	Mon, 15 Oct 2001 06:55:39 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200110151055.MAA12072@arpa.it.uc3m.es>
Subject: Re: 2.4.13-pre1: sonypi.c compile error
In-Reply-To: <3BCB0A02.9DF231A@zonnet.nl> from "Sander van Geloven" at "Oct 15,
 2001 12:08:34 pm"
To: "Sander van Geloven" <svgeloven@zonnet.nl>
Date: Mon, 15 Oct 2001 12:55:48 +0200 (MET DST)
Cc: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Sander van Geloven wrote:"
> >
> > I won't submit a patch to Linus for now, I'm pretty sure that Alan will take care of this for -pre2.
> > Stelian.

As far as I recall, I have pre2 and it showed this error on compiling the sony
vaio stuff. I fixed it by adding an extern int declaration for
is_sony_vaio_laptop in sonypi.c. It was declared in some nonobvious .c file
far elsewhere, uh, ... arch/i386/kernel/dmi_scan.c.

There seemed to be a need for an acl.h somewhere too, but maybe that was my
xfs patch.

Peter
