Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265897AbRF3MDC>; Sat, 30 Jun 2001 08:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbRF3MCw>; Sat, 30 Jun 2001 08:02:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13583 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265897AbRF3MCg>; Sat, 30 Jun 2001 08:02:36 -0400
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
To: rmk@arm.linux.org.uk (Russell King)
Date: Sat, 30 Jun 2001 13:01:18 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), adam@yggdrasil.com (Adam J. Richter),
        kaos@ocs.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <20010630125855.B12788@flint.arm.linux.org.uk> from "Russell King" at Jun 30, 2001 12:58:55 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15GJR8-0001xJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Err, how can $BAR be undefined?  Configure sets all config variables which
> > > are answered with 'n' to 'n'.
> > 
> > Welcome to the 'if' statement....
> Thank you, yes, but I believe we were talking about dep_* and not if
> statements?

No we are talking about Config.in scripts

	if [ condition ]
		bool 'foo' CONFIG_FOO

	fi

	dep_tristate ... $CONFIG_FOO

> 

