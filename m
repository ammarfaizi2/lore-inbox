Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130398AbQKHBRa>; Tue, 7 Nov 2000 20:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbQKHBRV>; Tue, 7 Nov 2000 20:17:21 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:46528 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S130398AbQKHBRR>;
	Tue, 7 Nov 2000 20:17:17 -0500
Date: Tue, 7 Nov 2000 17:14:01 -0800
From: Jean Tourrilhes <jt@spica.hpl.hp.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.rutgers.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dagb@fast.no>
Subject: [RANT] Linux-IrDA status
Message-ID: <20001107171401.A24041@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	(I'm not on the Linux kernel mailing list)

	The IrDA stack in Linux is non functional and has some major
critical bugs :
                        http://linux24.sourceforge.net/
	Not only it doesn't work, but it can crash your kernel fast.

	Most might wonder why the IrDA stack is in such state of
disrepair. Is there no maintainers and nobody who cares ?
	The truth is that every 2 month, Dag Brattli, the official
maintainer of the IrDA stack (see MAINTAINERS), collect all our
patches and send the latest official Linux-IrDA patch to Linus.
	And every time the patch never materialise in the Linux
kernel. Of course, Dag never receive any answer, so doesn't know why
his patches are going directly to /dev/null.
	As we fix more bugs, the official IrDA patch get growing and
growing. The patch that Dag sent last week to Linus was 320k. It has
slowly accumulated over one year :-(

	On the other hand, what never cease to amaze me is that some
patches to the IrDA code gets into the kernel. Some of those patches
make things better, some make things worse. Those patches certainly
don't come from Dag or any of the most active Linux-IrDA hacker, and
none of us see those patches in advance so that we get a chance to
comment on them and test them.
	I guess that some people have trouble reading the MAINTAINERS
file :-( Or maybe there is another maintainer for the IrDA stack and
none of us knows about it.


	I think for us the only solution is to ignose what's happening
in the 2.4.X kernel and have Dag maintaining Linux-IrDA separate from
the kernel. I don't see why Dag should take the effort to send regular
patch to Linus if they get ignored.
	In other words, the chances to have IrDA working in kernel 2.4
are *very* slim at this point.
	So, if people are interested in IrDA and want to use it, they
should suscribe to the Linux-IrDA mailing list and can ask me the
latest patch (Dag is now too discouraged). We will put it in the usual
place on Sourceforge...

	I hope it clarify a few things...

	Jean
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
