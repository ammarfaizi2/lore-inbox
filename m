Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTKTTC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 14:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTKTTC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 14:02:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:662 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262888AbTKTTC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 14:02:57 -0500
Date: Thu, 20 Nov 2003 10:57:28 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: bruce@perens.com (Bruce Perens)
Cc: linux-kernel@vger.kernel.org, dwmw2@infradead.org
Subject: Re: [PATCH/RFC] Re: Crash-on-boot in init_l440gx SMP
Message-Id: <20031120105728.16076bfe.rddunlap@osdl.org>
In-Reply-To: <20031120170150.GA21782@perens.com>
References: <20031030200203.159BD321@workstation.perens.com>
	<20031031114849.3e2c5425.rddunlap@osdl.org>
	<20031120170150.GA21782@perens.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Nov 2003 09:01:50 -0800 bruce@perens.com (Bruce Perens) wrote:

| Randy,
| 
| I ran this patch on my main server for two weeks. Just yesterday we had
| one kernel hang that I have no reason to believe is related to the patch,
| especially since it took two weeks to come up. We have had no other problems
| related to the kernel in that time.
| 
| Regarding the hang, it appears that disk I/O was blocked. I hit
| Ctrl-Alt-SysRequest-s, and it started working again. I'm sorry to have
| no other information on that.

Hi,

Linus merged a better patch for this here:
http://linus.bkbits.net:8080/linux-2.5/cset@1.1396.4.1?nav=index.html|ChangeSet@-3w
or here:
http://www.kernel.org/pub/linux/kernel/v2.6/testing/cset/cset-rddunlap@osdl.org%5Btorvalds%5D|ChangeSet|20031105003235|06865.txt


If you could test that patch, or just the latest patched version,
and let us know if there is still a problem, that would be Good.

Thanks,
--
~Randy
MOTD:  Always include version info.
