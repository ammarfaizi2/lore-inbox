Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271414AbTHDIn1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 04:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271415AbTHDIn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 04:43:27 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:30947 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S271414AbTHDInZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 04:43:25 -0400
Date: Mon, 4 Aug 2003 10:43:07 +0200
From: Martin Pitt <martin@piware.de>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, vitaly@namesys.com
Subject: Re: PROBLEM: 2.6.0-test1/2 reiserfsck journal replaying hangs
Message-ID: <20030804084306.GB15110@donald.balu5>
References: <20030803102321.GA428@donald.balu5> <20030804075420.GB4396@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030804075420.GB4396@namesys.com>
User-Agent: Mutt/1.5.4i
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.1; AVE: 6.20.0.1; VDF: 6.20.0.55
	 at server1 has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg and all others,

Am 2003-08-04 11:54 +0400 schrieb Oleg Drokin:
> On Sun, Aug 03, 2003 at 12:23:25PM +0200, Martin Pitt wrote:
> 
> > [1.] PROBLEM: 2.6.0-test1/2 reiserfsck journal replaying hangs
> > [2.] I use only reiserfs hd partitions. When booting 2.6.0-test2,
> > fsck'ing the root file system causes a journal replay which hangs
> > forever; one has to interrupt it (^C) and continue manually. When
> 
> HUH???
> So you are starrting reiserfsck on rootfs and it starts to
> replay a journal? That's really weird (but seems there is nthing to do with
> kernel, though).

Well, it is started automatically. Actually, the line "replaying
journal" appears with every boot and it also lasts a while, so I
suppose it is actually done. fsck and replaying works with all other
file systems, it only hangs with the root fs.

It must have to do with the kernel at least partially since everything
works fine with 2.4.x.

I would be happy to help with debugging, but I need some guidance
since I'm not familiar with the kernel internals.

> What reiserfsprogs version do you use?

3.6.6, the kernel Changes says that 3.6.3 is required at least, thus
it should be okay.

Thanks in advance and have a nice day!

Martin
-- 
Martin Pitt
home:  www.piware.de
eMail: martin@piware.de

Es gibt zwei Regeln für Erfolg im Leben:
1. Erzähle den Leuten nie alles, was Du weißt.
