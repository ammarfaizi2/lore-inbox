Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVBWTev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVBWTev (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 14:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVBWTev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 14:34:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47302 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261544AbVBWTeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 14:34:46 -0500
Date: Wed, 23 Feb 2005 05:12:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.30-pre2
Message-ID: <20050223081209.GA13991@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes the second pre of v2.4.30.

It contains a bunch of important networking fixes, most noticeably the brlocks rework.

Plus USB fixes, megaraid2 driver update, JFS update, amongst others.

Read the changelog for detailed information

Summary of changes from v2.4.30-pre1 to v2.4.30-pre2
============================================

<krzysztof.h1:wp.pl>:
  o [SPARC32]: Need to clear PSR_EF in psr of childregs on fork() on SMP

<marcelo:dmt.cnet>:
  o Changed VERSION to v2.4.30-pre2

<temnota+kernel:kmv.ru>:
  o megaraid2 reorder inline functions

<vvs:sw.ru>:
  o megaraid2 update 2.10.8.2

Charles-Edouard Ruault:
  o Reserve only needed regions for PC timers on i386 and x86_64

Dave Kleikamp:
  o JFS: remove invalid NULL assignments to i_sb
  o JFS: fix livelock waiting for stale metapage
  o JFS: mount option iocharset=none
  o JFS: change project url to http://jfs.sourceforge.net/

David S. Miller:
  o [SPARC]: Fix bogus trailing semicolon in smb_*() macros
  o [SPARC]: nop() macro has bogus trailing semicolon
  o [TG3]: Update driver version and reldate
  o [SPARC64]: Fix trailing semicolon in membar macros
  o [COMPAT]: TUNSETIFF needs to copy back data after ioctl
  o [TG3]: Always check tg3_readphy() return value
  o [TG3]: Update driver version and reldate
  o [BRLOCKS]: Delete atomic version, is buggy and deadlock prone

Domen Puncer:
  o JFS: delete unused file

Eugene Surovegin:
  o 2.4: fix bogus 440GX rev.C PVR

Hideaki Yoshifuji:
  o [NET]: Fix kernel oops if base_reachable_time is set to 0

Jean Tourrilhes:
  o [NET]: Backport SIOCSIFNAME wildcarding support from 2.6.x

Kenneth Sumrall:
  o Kenneth Sumrall: In lp_write(), copy_from_user() is called to copy data into a statically allocated kernel buffer before down_interruptible()

Michael Chan:
  o [TG3]: capacitive coupling detection fix

Patrick McHardy:
  o [PKT_SCHED]: Fix u32 double listing
  o [NETLINK]: Unhash sockets correctly

Pete Zaitcev:
  o USB: ftdi_sio
  o USB: hid for ia64
  o USB: fix modem_run
  o USB: mct_u232

Stephen Hemminger:
  o [TCP]: Fix BIC max_cwnd calculation error

Stephen Rothwell:
  o PPC64: 32 bit sys_recvmsg corruption
  o Fixup 32 bit sys_recvmsg corruption patch

Thomas Graf:
  o [TCP]: Fix calculation for collapsed skb size

