Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbVDHMbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbVDHMbE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 08:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbVDHMbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 08:31:03 -0400
Received: from zxa8020.lanisdn-gte.net ([206.46.31.146]:42973 "EHLO
	links.magenta.com") by vger.kernel.org with ESMTP id S262797AbVDHMav
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 08:30:51 -0400
Date: Fri, 8 Apr 2005 08:30:36 -0400
From: Raul Miller <moth@debian.org>
To: debian-legal@lists.debian.org, linux-kernel@vger.kernel.org,
       linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050408083036.B32136@links.magenta.com>
References: <20050407161658.S32136@links.magenta.com> <MDEHLPKNGKAHNMBLJOLKEEPFCPAB.davids@webmaster.com> <20050407235544.Y32136@links.magenta.com> <20050408074135.GA9057@pegasos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050408074135.GA9057@pegasos>; from sven.luther@wanadoo.fr on Fri, Apr 08, 2005 at 09:41:35AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 09:41:35AM +0200, Sven Luther wrote:
> BTW, have any of you read the analysis i made, where i claim, rooted
> in the GPL FAQ and with examples, why i believe that the firmware can
> be considerated a non derivative of the linux kernel.

I hadn't.  I did just now.  Here's my opinions, after reading it:

[1a] It's pretty long, and some of the redundancy is not really relevant
to the issue at hand.  This might be less of an issue, except

[1b] It has some grammar problems that should be fixed.

[2] The presented arguments all look plausible.  Maybe I should study
it more, but I didn't see any significant logical flaws.

[3] It focuses on debian issues more than kernel issues (though a
dedicated reader could see some issues relevant to the linux-kernel
mailing list).

I agree with both you and the gpl faq writers that "communicates at arms
length" is probably a good measure of whether or not the kernel and the
module are the same program.  I can think of cases where this wouldn't
hold (GPLed documentation, for example), but those kinds of issues don't
seem to be relevant here.

> I further argumented that taking any different stance would bring us worlds of
> hurt as we would consider the bios as being a derivative work of the kernel
> they are running, or the bootloader, or the firmware present in proms on
> devices loaded into the system and so on.

Here, you've confused two issues:  "Are A and B part of the same program?"
and  "Are A and B together part of a derivative work under copyright law?"
Sometimes one is true, sometimes the other is true.  You have a GPL
issue when both are true.

One question has to do with the function of A and B.  The other question
is whether the combination is eligible for copyright protection.
Copyright protection is not granted or denied because of functionality.
The functional issues are relevant only because they're written into
the license.

Of course there can be other GPL issues (e.g. it's bad to put a GPL
notice on something which isn't GPLed).

And, of course, there can be non-GPL issues (pulling the blobs out of
the kernel lets people update their firmware without having to compile
the kernel or a kernel module).

> I think only the fact that if you consider firmware as being a derivative
> work, you should consider it a derivative work also when it is flashed on the
> prom of a pci card or what not, is decisive enough to make those firmware
> blobs not derivative works of the kernel they are under.

Uh... not precisely.  You have your facts straight, but your logic is bad.
This fact alone isn't enough to decide whether or not firmware is a
derivative work.

Fortunately this thought isn't a big deal for the cases we're currently
talking about.

-- 
Raul
