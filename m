Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269546AbRGaX63>; Tue, 31 Jul 2001 19:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269558AbRGaX6T>; Tue, 31 Jul 2001 19:58:19 -0400
Received: from b0rked.dhs.org ([216.99.196.11]:26753 "HELO b0rked.dhs.org")
	by vger.kernel.org with SMTP id <S269557AbRGaX6K>;
	Tue, 31 Jul 2001 19:58:10 -0400
Date: Tue, 31 Jul 2001 16:58:06 -0700 (PDT)
From: Chris Vandomelen <chrisv@b0rked.dhs.org>
X-X-Sender: <chrisv@linux.local>
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
Cc: Guest section DW <dwguest@win.tue.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: Re[2]: cannot copy files larger than 40 MB from CD
In-Reply-To: <200107312346.BAA1546019@mail.takas.lt>
Message-ID: <Pine.LNX.4.31.0107311656420.10245-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Tried vfat, ext2 and reiserfs.
>
> BTW, kernel is compiled with gcc-2.96-85, glibc-2.2.2-10 (RH 7.1) if
                               ^^^^^^^^^^^
> that matters.

Have you tried compiling your kernel using kgcc?

gcc-2.96.* is known to compile code incorrectly AFAIK, and shouldn't be
used for compiling kernels. (kgcc is egcs-1.1.2, I think.)

Chris

