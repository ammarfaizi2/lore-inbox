Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265101AbRG0Vs6>; Fri, 27 Jul 2001 17:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265149AbRG0Vss>; Fri, 27 Jul 2001 17:48:48 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:2322 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265101AbRG0Vsd>; Fri, 27 Jul 2001 17:48:33 -0400
Message-ID: <3B61E16D.26E81AA9@namesys.com>
Date: Sat, 28 Jul 2001 01:47:25 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "A. Lehmann" <"pcg( Marc)"@goof.com>,
        Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <E15QF6A-0006Za-00@the-village.bc.nu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox wrote:
> 
> > Let us be a bit more precise here.  If you click on the help button when deciding whether to select
> > that option it tells you not to do it.  What can you say about a distro that doesn't read the help
> > buttons for the kernel options when configuring the kernel?  Shovelware?
> 
> The alternative was to disable it. Because at the time we had lots of good
> evidence it didnt work reliably. Evidence backed up by the pile of later
> Chris Mason patches.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Better to disable it than to cripple it.

By the way, how about considering the use of tests before redhat coders put stuff in the linux
kernel?  You know, if VFS changes actually got tested before users encountered things like Viro
breaking ReiserFS in 2.4.5, it would be nice.

At Namesys, like all normal software shops, we actually run a test suite before shipping code
externally.  We usually try to require that it be tested by at least one person in addition to the
code author.

It would catch things like your gcc problems.  Test suites don't catch everything, but they are
considered the responsible thing to do at most places.

Hans
