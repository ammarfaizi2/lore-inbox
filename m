Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTLCAew (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 19:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264466AbTLCAew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 19:34:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:4266 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264464AbTLCAes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 19:34:48 -0500
Date: Tue, 2 Dec 2003 16:27:45 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: fuzzy77@free.fr, zwane@zwane.ca, linux-kernel@vger.kernel.org
Subject: Re: [kernel panic @ reboot] 2.6.0-test10-mm1
Message-Id: <20031202162745.40c99509.rddunlap@osdl.org>
In-Reply-To: <20031203003106.GF4154@mis-mike-wstn.matchmail.com>
References: <3FC4DA17.4000608@free.fr>
	<Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com>
	<3FC4E42A.40906@free.fr>
	<Pine.LNX.4.58.0311261240210.1683@montezuma.fsmlabs.com>
	<3FC4E8C8.4070902@free.fr>
	<Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com>
	<20031126233738.GD1566@mis-mike-wstn.matchmail.com>
	<3FC53A3B.50601@free.fr>
	<20031202160303.2af39da0.rddunlap@osdl.org>
	<20031203003106.GF4154@mis-mike-wstn.matchmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Dec 2003 16:31:06 -0800 Mike Fedyk <mfedyk@matchmail.com> wrote:

| On Tue, Dec 02, 2003 at 04:03:03PM -0800, Randy.Dunlap wrote:
| > On Thu, 27 Nov 2003 00:41:47 +0100 Vince <fuzzy77@free.fr> wrote:
| > 
| > | Mike Fedyk wrote:
| > | > Interesting.  It would be nice to have a boot option that halts the system
| > | > after the first oops, instead of trying to continue.
| > 
| > You mean like the "panic_on_oops" sysctl??  (implemented in i386 & ppc64)
| 
| ...
| 
| > From Vince:
| > | It worked, but I had -- as expected -- to write the oops by hand.
| > | (user request to Randy: would it be possible to have an option in 
| > | kmsgdump to only write the first oops on floppy ???)
| > 
| > Um, could you elaborate on why you would want that?
| > kmsgdump assumes that the entire floppy belongs to it, so there
| > should be plenty of room for multiple oopsen (although I don't
| > know what it does on disk-full....).
| > 
| > I plan to add support for > 32 KB log buf sizes, but that's all I have
| > planned for now.
| 
| Wouldn't he only get the first oops on the diskette if he had the sysctl
| mentioned above enabled?

Yes, I think that you are right.

--
~Randy
MOTD:  Always include version info.
