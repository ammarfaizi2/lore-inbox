Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTL3Xre (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 18:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbTL3Xre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 18:47:34 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:2509 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S264389AbTL3Xrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 18:47:33 -0500
Date: Wed, 31 Dec 2003 00:46:43 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
Message-ID: <20031230234643.GB8412@k3.hellgate.ch>
Mail-Followup-To: Thomas Molina <tmolina@cablespeed.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> <Pine.LNX.4.58.0312291420370.1586@home.osdl.org> <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain> <Pine.LNX.4.58.0312291502210.1586@home.osdl.org> <Pine.LNX.4.58.0312300903170.2825@localhost.localdomain> <20031230143929.GN27687@holomorphy.com> <Pine.LNX.4.58.0312301524220.3152@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312301524220.3152@localhost.localdomain>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Dec 2003 16:14:13 -0500, Thomas Molina wrote:
> I also get 90+ percent iowait under 2.6 and 0 iowait in 2.4.  I'm not sure 
> how the alleged suckiness of 2.6 paging fits into this.  On this system 

It is not alleged. It is real, but the badness is not universal. I was
afraid I'd have to add another category, but fortunately it seems bk
export matches qsbench: Major regressions neither between test2 and
test3 nor between 2.4 and 2.6.

I'm still interested to learn whether 2.5.39 is a major regression
(fixed later) for bk export, although that might have been due to the
qs specific reference patterns, I haven't looked into it. At least for
qsbench the spike is confirmed though, even with different parameters.

Roger
