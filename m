Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266254AbUAMXGh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266251AbUAMXGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:06:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:24043 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266244AbUAMXGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:06:34 -0500
Date: Tue, 13 Jan 2004 15:03:19 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Re: modprobe failed: digest_null
Message-Id: <20040113150319.1e309dcb.rddunlap@osdl.org>
In-Reply-To: <20040113225047.GA6891@piper.madduck.net>
References: <20040113215355.GA3882@piper.madduck.net>
	<20040113143053.1c44b97d.rddunlap@osdl.org>
	<20040113223739.GA6268@piper.madduck.net>
	<20040113144141.1d695c3d.rddunlap@osdl.org>
	<20040113225047.GA6891@piper.madduck.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004 23:50:47 +0100 martin f krafft <madduck@madduck.net> wrote:

| also sprach Randy.Dunlap <rddunlap@osdl.org> [2004.01.13.2341 +0100]:
| > I would guess that you have a high-priority $PATH to old modprobe
| > than to the new modprobe...
| 
| That would surprise me, Debian handles this quite well:
| 
| diamond:~# which modprobe
| /sbin/modprobe
| diamond:~# modprobe -V
| module-init-tools version 3.0-pre5
| diamond:~# modprobe.modutils -V
| modprobe version 2.4.26
| modprobe: QM_MODULES: Function not implemented
| diamond:~# uname -r
| 2.6.1

OK, maybe someone else has an answer then.

The message:
kernel: request_module: failed /sbin/modprobe -- digest_null. error = 256
is from modutils and not from module-init-tools according to my
source files.

--
~Randy
MOTD:  Always include version info.
