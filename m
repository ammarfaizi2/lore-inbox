Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVARLvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVARLvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 06:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVARLvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 06:51:49 -0500
Received: from canuck.infradead.org ([205.233.218.70]:30981 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261206AbVARLvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 06:51:37 -0500
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
From: Arjan van de Ven <arjan@infradead.org>
To: Tigran Aivazian <tigran@veritas.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@muc.de>,
       Jan Hubicka <jh@suse.cz>, Jack F Vogel <jfv@bluesong.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0501181112120.2911@ezer.homenet>
References: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet>
	 <20050114205651.GE17263@kam.mff.cuni.cz>
	 <Pine.LNX.4.61.0501141613500.6747@chaos.analogic.com>
	 <cs9v6f$3tj$1@terminus.zytor.com>
	 <Pine.LNX.4.61.0501170909040.4593@ezer.homenet>
	 <1105955608.6304.60.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0501171002190.4644@ezer.homenet>
	 <41EBFF87.6080105@zytor.com> <m1wtubvm8y.fsf@muc.de>
	 <41EC224D.5080204@zytor.com>
	 <Pine.LNX.4.61.0501181112120.2911@ezer.homenet>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 12:51:00 +0100
Message-Id: <1106049060.6307.73.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-18 at 11:25 +0000, Tigran Aivazian wrote:

> However, this highlighted a more serious problem in the x86_64 kernel (or 
> more likely in the kdb patch) --- the kernel compiled with -g panics when 
> you try to return from kdb after hitting a breakpoint. This is a bug and 
> I'll investigate to find out the reason why it panics. (I hope it is not 
> an "assumption" of the x86_64 port that one must never compile the kernel 
> with -g either...)

That is isn't; for example the Fedora Core 2 and 3 and the Red Hat
Enterprise Linux 4 kernels are compiled wit -g.


