Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271685AbTHDJRG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 05:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271686AbTHDJRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 05:17:06 -0400
Received: from angband.namesys.com ([212.16.7.85]:62357 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S271685AbTHDJRE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 05:17:04 -0400
Date: Mon, 4 Aug 2003 13:17:03 +0400
From: Oleg Drokin <green@namesys.com>
To: Martin Pitt <martin@piware.de>
Cc: linux-kernel@vger.kernel.org, vitaly@namesys.com
Subject: Re: PROBLEM: 2.6.0-test1/2 reiserfsck journal replaying hangs
Message-ID: <20030804091703.GC3911@namesys.com>
References: <20030803102321.GA428@donald.balu5> <20030804075420.GB4396@namesys.com> <20030804084306.GB15110@donald.balu5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804084306.GB15110@donald.balu5>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Aug 04, 2003 at 10:43:07AM +0200, Martin Pitt wrote:
> > > [1.] PROBLEM: 2.6.0-test1/2 reiserfsck journal replaying hangs
> > > [2.] I use only reiserfs hd partitions. When booting 2.6.0-test2,
> > > fsck'ing the root file system causes a journal replay which hangs
> > > forever; one has to interrupt it (^C) and continue manually. When
> > HUH???
> > So you are starrting reiserfsck on rootfs and it starts to
> > replay a journal? That's really weird (but seems there is nthing to do with
> > kernel, though).
> Well, it is started automatically. Actually, the line "replaying
> journal" appears with every boot and it also lasts a while, so I
> suppose it is actually done. fsck and replaying works with all other
> file systems, it only hangs with the root fs.

Hm, have you tried to press any other keys prior to ^C?
What was screen looking like at the hang time (can you capture it somehow?),
can you press sysrq-T at the time of a hang and then send us the traces?

Thank you.

Bye,
    Oleg
