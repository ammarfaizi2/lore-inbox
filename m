Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268859AbRG0NwI>; Fri, 27 Jul 2001 09:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268857AbRG0Nv4>; Fri, 27 Jul 2001 09:51:56 -0400
Received: from [213.69.58.122] ([213.69.58.122]:7068 "EHLO syntags.de")
	by vger.kernel.org with ESMTP id <S268856AbRG0Nvo>;
	Fri, 27 Jul 2001 09:51:44 -0400
Message-Id: <200107271351.f6RDppN22826@syntags.de>
Content-Type: text/plain; charset=US-ASCII
From: Frank Fiene <ffiene@veka.com>
Organization: VEKA AG
To: linux-kernel@vger.kernel.org
Subject: Re: Graphical overview (close)
Date: Fri, 27 Jul 2001 15:51:50 +0200
X-Mailer: KMail [version 1.2.3]
In-Reply-To: <20010727145202.A507@freakzone.net> <200107271337.f6RDbVN22777@syntags.de>
In-Reply-To: <200107271337.f6RDbVN22777@syntags.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Friday, 27. July 2001 15:37, Frank Fiene wrote:
> On Friday, 27. July 2001 14:52, Gordon Fraser wrote:
> > Frank Fiene <ffiene@veka.com> [010727 13:19] wrote:
> > > Where can i find the graphical overview of the linux kernel
> > > source tree? I saw a big jpg and a link to a homepage, but i
> > > lost the informations.
> >
> > This is what you're looking for:
> > http://fcgp.sourceforge.net/
>
> Thanks, Gordon and Jan-Benedict.
>
> lgp version 2.4.0a works fine but the latest 2.5.1 does not.
> Compile error is
> data2ps.o: In function `d2p_draw_line':
> /home/ffiene/docs/lgp-2.5.1/data2ps.c:180: undefined reference to
> `cos'
> /home/ffiene/docs/lgp-2.5.1/data2ps.c:181: undefined reference to
> `sin'
>
> The files data2ps.c in both versions have not man different lines
> of code, so i didn't find the error.

OK, error in Makefile.
It doesn't link with the math library.

ff
-- 
Frank Fiene, SYNTAGS GmbH, Im Defdahl 5-10, D-44141 Dortmund, Germany
Security, Cryptography, Networks, Software Development
http://www.syntags.de mailto:Frank.Fiene@syntags.de
