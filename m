Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129687AbQKBBNd>; Wed, 1 Nov 2000 20:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130609AbQKBBNY>; Wed, 1 Nov 2000 20:13:24 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:16908 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129687AbQKBBNK>;
	Wed, 1 Nov 2000 20:13:10 -0500
Message-ID: <3A00BF7F.5C7CB1D7@mandrakesoft.com>
Date: Wed, 01 Nov 2000 20:12:31 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "J . A . Magallon" <jamagallon@able.es>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
In-Reply-To: <E13r6lL-0000w4-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> J. A. Magallon wrote:
> > I have noticed that in latest patch for 2.4.0, the global Makefile
> > no more tries to find a kgcc, and falls back to gcc.

The global Makefile in 2.4.x -never- looked for kgcc.


> > I suppose because 2.7.2.3 is no more good for kernel, but still you
> > can use 2.91, 2.95.2 or 2.96(??). Is that a patch that leaked in
> > the way to test10, or is for another reason ?.
> 
> I've not yet submitted it to Linus is the obvious reason 8)

You're not changing 2.4.x to use kgcc, are you?  It seems to be working
fine under gcc 2.95.2+fixes...

	Jeff



-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
