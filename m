Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbUEQR1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUEQR1Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 13:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUEQR1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 13:27:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:17088 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261937AbUEQRZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 13:25:57 -0400
Date: Mon, 17 May 2004 10:16:38 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Cc: jpiszcz@lucidpixels.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.5 emu10k1 module FAILS, built-in OK.
Message-Id: <20040517101638.0b844763.rddunlap@osdl.org>
In-Reply-To: <5D3C2276FD64424297729EB733ED1F7605FAE6AC@email1.mitretek.org>
References: <5D3C2276FD64424297729EB733ED1F7605FAE6AC@email1.mitretek.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2004 11:23:37 -0400 Piszcz, Justin Michael wrote:

| Does creative still help maintain this module?
| Is there an #include <string-something.h> missing in the module (WHEN
| COMPILED W/SMP support, or?)
| jpiszcz@slack91:/usr/src/linux/Documentation$ find .|grep -i emu101k
| jpiszcz@slack91:/usr/src/linux/Documentation$ find .|grep -i emu101
| jpiszcz@slack91:/usr/src/linux/Documentation$ grep emu101k -r *
| grep: networking/netif-msg.txt: Permission denied
| grep: scsi/ChangeLog.megaraid: Permission denied
| jpiszcz@slack91:/usr/src/linux/Documentation$
| 
| (2.6.5 kernel)

WorksForMe, 2.6.5 or 2.6.6.  What .config ?


| -----Original Message-----
| From: linux-kernel-owner@vger.kernel.org
| [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Justin Piszcz
| Sent: Saturday, May 15, 2004 6:08 PM
| To: linux-kernel@vger.kernel.org
| Subject: Re: Linux 2.6.5 emu10k1 module FAILS, built-in OK.
| 
| Let me remind all; this is with _SMP_ kernel only, with a regular kernel
| it makes the module and loads it fine.
| 
| Anyone aware of this problem?
| 
| On Sat, 15 May 2004, Justin Piszcz wrote:
| 
| > Script started on Sat May 15 14:47:08 2004
| > # modprobe emu10k1
| > FATAL: Error inserting emu10k1
| > (/lib/modules/2.6.5/kernel/sound/oss/emu10k1/emu10k1.ko): Unknown
| symbol
| > in module, or unknown parameter (see dmesg)
| > root@war:~# dmesg | tail -n 1
| >  emu10k1: Unknown symbol strcpy
| >
| >
| -


--
~Randy
