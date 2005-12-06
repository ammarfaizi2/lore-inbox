Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751688AbVLFI3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbVLFI3c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 03:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbVLFI3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 03:29:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40339 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751687AbVLFI3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 03:29:31 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: Arjan van de Ven <arjan@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051206011844.GO28539@opteron.random>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <20051205121851.GC2838@holomorphy.com>
	 <20051206011844.GO28539@opteron.random>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 09:29:26 +0100
Message-Id: <1133857767.2858.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 02:18 +0100, Andrea Arcangeli wrote:
> On Mon, Dec 05, 2005 at 04:18:51AM -0800, William Lee Irwin III wrote:
> > The December 6 event is extraordinarily unlikely. What's vastly more
> > likely is consistent "erosion" over time. First the 3D video drivers,
> > then the wireless network drivers, then the fakeraid drivers, and so on.
> 
> I agree about the erosion.
> 
> I am convinced that the only way to stop the erosion is to totally stop
> buying hardware that has only binary only drivers (unless you buy it to
> create an open source driver or to reverse engineer the binary only
> driver of course! ;).

this only works if more people than "just Andrea and Arjan" do it
though.

> 
> For example if a laptop has an embedded wirless or 3d card not supported by
> open source drivers, buy a laptop without any wireless card or without
> 3d, instead of buying one with the not-supported hardware without using
> it (I can guarantee there are still laptops that requires no 3d
> binary only drivers and no wirless cards drivers, even for the winmodems
> you can choose the ones supported by alsa). We literally have to refuse
> buying those cards with binary only kernel drivers.

I fully agree; I bought a centrino based laptop recently (from Dell),
because Intel did a most excellent job of getting all the parts I use
supported fully. That was actually my primary purchase criterium.
Several other vendors didn't get my sale because they had no decent
supported laptop. (eg ati or nvidia video or some at-the-time driverless
wireless)


> The fact Arjan got the "nvidia fanboy" complaining, is the  sign that
> some people just don't care. This understandable for a 3d kind of
> product which is 90% for entertainment (nobody loses money when it
> crashes), and we generally can't expect everyone to care about the long
> term kernel development.

lately a trend started where linux users consider it normal to use
binary drivers. Not only for 3D, but for everything. To the point where
in discussions about the gpl bcm43xx driver in development they feel
it's useful to chime in by saying "just use ndiswrapper instead", in
fact that's the standard answer on mailinglist on ANY wireless issue
nowadays it seems. There is an atmosphere that it's the duty of the
kernel developers to keep nvidia and ndiswrapper and all other binary
drivers working, anyone who even suggests different is a fundamentalist
GPL terrorist. (if you think that I'm overreacting, just for fun read
the forum on heise.de about this mail/article; this article apparently
is very fundamentalist). Nowadays people get upset and start calling
names if you point then at the nvidia forums instead of given them the
exact answer they want on $whatevermailinglist. 

So while I fully agree with your "we shouldn't buy the unsupported
hardware" I fear that that no longer is happening in practice, not even
on the server side anymore, where some of the linux-friendly hardware
vendors now sell machines which require binary only modules to run and
call it fully linux certified and don't even mention anywhere that it
needs such modules, or that those modules are only available for RHEL or
SLES.

Greetings,
   Arjan van de Ven



