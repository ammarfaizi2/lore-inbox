Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTLWRXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 12:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTLWRXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 12:23:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:232 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261956AbTLWRXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 12:23:02 -0500
Date: Tue, 23 Dec 2003 09:21:04 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [bug] 2.6.0 COMMAND_LINE_SIZE <160???
Message-Id: <20031223092104.6bc9f634.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312232102340.5732@silk.corp.fedex.com>
References: <Pine.LNX.4.58.0312232102340.5732@silk.corp.fedex.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003 21:07:45 +0800 (SGT) Jeff Chua <jeffchua@silk.corp.fedex.com> wrote:

| 
| I can't seems to pass more than 160 bytes on command line when booting
| linux-2.6.0. 2.4.24 is ok.
| 
| Booting via loadlin, but I've tried linld, still the same problem.
| 
| It hangs after "Ok, booting the kernel".

So 2.4.24-pre works OK for you.

2.6.0 works OK for me with a command line length of 219 bytes
(about half of it doesn't matter for booting, but it's all
there in /proc/cmdline).  Using lilo.

Same processor arch. type in both .config files?
Same compiler version building them?

--
~Randy
MOTD:  Always include version info.
