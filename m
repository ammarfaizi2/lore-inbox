Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269248AbTGUFEH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 01:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269249AbTGUFEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 01:04:07 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31616
	"EHLO x30.random") by vger.kernel.org with ESMTP id S269248AbTGUFEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 01:04:05 -0400
Date: Sat, 19 Jul 2003 19:21:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jim Gifford <maillist@jg555.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre5 deadlock
Message-ID: <20030719172103.GA1971@x30.local>
References: <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva> <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva> <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva> <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva> <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307141145340.23121@freak.distro.conectiva> <008701c34a29$caabb0f0$3400a8c0@W2RZ8L4S02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008701c34a29$caabb0f0$3400a8c0@W2RZ8L4S02>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 10:03:03AM -0700, Jim Gifford wrote:
> As requested.

please try to reproduce w/o devfs and/or w/o a kernel module that is
loadable called ipt_psd (netfilter stuff likely, but not part of
mainline pre6/pre7). probably it'll go away either ways and it seems
triggered by the process called couriertcpd. Not sure exactly what's
going on though, since looking into devfs/devfsd doesn't sound
interesting anymore and I don't see the netfilter code out of mainline.

(probably this email will get some delay, so apologies if it is obsolete
by the time it reaches the network)

Andrea
