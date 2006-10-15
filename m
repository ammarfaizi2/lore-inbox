Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWJOMmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWJOMmP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 08:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWJOMmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 08:42:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10761 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750745AbWJOMmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 08:42:14 -0400
Date: Sun, 15 Oct 2006 14:42:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [0/3] 2.6.19-rc2: known regressions
Message-ID: <20061015124210.GX30596@stusta.de>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <20061014111458.GI30596@stusta.de> <20061015122453.GA12549@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061015122453.GA12549@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2006 at 01:24:54PM +0100, Russell King wrote:
> On Sat, Oct 14, 2006 at 01:14:58PM +0200, Adrian Bunk wrote:
> > As usual, we are swamped with bug reports for regressions after -rc1.
> > 
> > For an easier reading (and hoping linux-kernel might not eat the emails), 
> > I've splitted the list of known regressions in three emails:
> >   [1/3] known unfixed regressions
> >   [2/3] knwon regressions with workarounds
> >   [3/3] known regressions with patches
> 
> There's a raft of ARM regressions as well (see
> http://armlinux.simtec.co.uk/kautobuild/2.6.19-rc2/index.html), mostly
> related to the IRQ changes, as well as this error:

Thanks, I'll look at them before preparing the next version of my 
regressions list.

> sysctl_net.c:(.text+0x64a8c): undefined reference to `highest_possible_node_id'

This problem already got an entry a few hours ago:

Subject    : undefined reference to highest_possible_node_id
References : http://lkml.org/lkml/2006/9/4/233
             http://lkml.org/lkml/2006/10/15/11
Submitter  : Olaf Hering <olaf@aepfle.de>
Caused-By  : Greg Banks <gnb@melbourne.sgi.com>
             commit 0f532f3861d2c4e5aa7dcd33fb18e9975eb28457
Status     : unknown

> Russell King

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

