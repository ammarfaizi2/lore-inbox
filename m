Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319507AbSH3Igw>; Fri, 30 Aug 2002 04:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319503AbSH3Igw>; Fri, 30 Aug 2002 04:36:52 -0400
Received: from AMarseille-201-1-3-142.abo.wanadoo.fr ([193.253.250.142]:14448
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S319501AbSH3Igu>; Fri, 30 Aug 2002 04:36:50 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
Subject: Re: ide-2.4.20-pre4-ac2.patch
Date: Fri, 30 Aug 2002 11:40:52 +0200
Message-Id: <20020830094052.26359@192.168.4.1>
In-Reply-To: <1030661741.1326.7.camel@irongate.swansea.linux.org.uk>
References: <1030661741.1326.7.camel@irongate.swansea.linux.org.uk>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Rejected. I found several errors, a couple of strange reverts and some
>files being moved to clearly wrong places. It also mixes up multiple
>changes.
>
>Andre to make this work I need
>	- One change per patch (within reason)
>	- An explanation of what it does
>
>For example I've got files you moved and changed, looking at that in
>diff is a right pita. I've got a big diff with errors in it (eg gayle in
>ppc) I can't easily be sure I can cleanly drop parts of.
>
>Lets start with the file moving. Send me a diff for the Config/Makefile
>and a lit of the files to move and where. Gayle I think should be m68k
>not ppc (actually Im pretty sure), CMD640 is PCI so why file it in
>legacy. "legacy" I took to mean pre PCI rather than "I think its junk"
>8)

Andre, you should probably remove my "patch0" from your patch
(the very first one I sent you to fix PPC compile on -ac so
you could test on your PPC). Alan already have it, I sent it
more for your own tests on PPC than for inclusion in your
patch, which is why I sent it separately from the other IDE
related patches.

Ben.


