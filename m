Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271278AbTHMAXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 20:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271279AbTHMAXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 20:23:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:11735 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271278AbTHMAXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 20:23:35 -0400
Date: Tue, 12 Aug 2003 17:20:28 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: Add hint on sysrq on some keyboards
Message-Id: <20030812172028.1eb1043d.rddunlap@osdl.org>
In-Reply-To: <20030812235848.GD306@elf.ucw.cz>
References: <20030812235848.GD306@elf.ucw.cz>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003 01:58:54 +0200 Pavel Machek <pavel@suse.cz> wrote:

| Hi!
| 
| This trick is maybe nontrivial... and it is needed on many
| machines. Please apply,
| 							Pavel
| 
| --- /usr/src/tmp/linux/Documentation/sysrq.txt	2003-03-27 10:39:46.000000000 +0100
| +++ /usr/src/linux/Documentation/sysrq.txt	2003-08-13 00:55:53.000000000 +0200
| @@ -22,7 +22,10 @@
|  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|  On x86   - You press the key combo 'ALT-SysRq-<command key>'. Note - Some
|             keyboards may not have a key labeled 'SysRq'. The 'SysRq' key is
| -           also known as the 'Print Screen' key.
| +           also known as the 'Print Screen' key. Also some keyboards can not
| +	   handle so many keys being pressed at the same time, so you might
| +	   have better luck with "press Alt", "press SysRq", "release Alt",
| +	   "press <command key>", release everything.
|  
|  On SPARC - You press 'ALT-STOP-<command key>', I believe.

Well, that is good info.

or use: 'echo key > /proc/sysrq-trigger' if your keyboard is working.

--
~Randy				For Linux-2.6, see:
http://www.kernel.org/pub/linux/kernel/people/davej/misc/post-halloween-2.5.txt
