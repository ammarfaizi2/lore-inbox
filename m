Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289018AbSBDPa2>; Mon, 4 Feb 2002 10:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289020AbSBDPaT>; Mon, 4 Feb 2002 10:30:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:531 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289018AbSBDPaN>; Mon, 4 Feb 2002 10:30:13 -0500
Subject: Re: [PATCH] Specialix RIO Oops fix
To: steve@silug.org (Steven Pritchard)
Date: Mon, 4 Feb 2002 15:43:24 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020204090200.A30872@osiris.silug.org> from "Steven Pritchard" at Feb 04, 2002 09:02:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16XlHA-0007Vu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch below fixes an Oops in the Specialix RIO driver.  I sent
> this to the maintainer a couple of months ago and never got a
> response.

Its not really going to help. You need to work out how it got like that
to have any chance it broke.

Until then it would be better to use


	if(....)
		BUG()

That will get a stack trace to show why it worked

> client that they would have to switch to the original Red Hat 7.1
> kernel (2.4.2-something) if they wanted it to actually work.

Thats not a good idea. 2.4.2 has security holes, and should not be used
in production systems. 
