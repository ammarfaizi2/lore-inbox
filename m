Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263508AbTJQPiF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 11:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263545AbTJQPiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 11:38:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:158 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263508AbTJQPiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 11:38:01 -0400
Date: Fri, 17 Oct 2003 08:36:41 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7 broken
Message-Id: <20031017083641.19d27a20.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.58L.0310171508480.20432@alpha.zarz.agh.edu.pl>
References: <Pine.LNX.4.58L.0310171508480.20432@alpha.zarz.agh.edu.pl>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Oct 2003 15:13:21 +0200 (CEST) "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl> wrote:

| I try to compile linux-2.6.0-test7 from ftp.kernel.org on SMP machine
| and I god something like this:
| 
| [...]
| Root device is (8, 1)
| Boot sector 512 bytes.
| Setup is 4943 bytes.
| System is 1298 kB
| Kernel: arch/i386/boot/bzImage is ready
|   Building modules, stage 2.
|   MODPOST
| [...]
| *** Warning: "set_special_pids" [fs/jffs/jffs.ko] undefined!

Andrew has a patch for this one in the -mm patchset.

--
~Randy
