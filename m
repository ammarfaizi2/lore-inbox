Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265893AbTL3W1r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbTL3W1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:27:17 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:61105 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S265893AbTL3W0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:26:40 -0500
Date: Tue, 30 Dec 2003 23:24:03 +0100
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>,
       Andy Isaacson <adi@hexapodia.org>,
       Thomas Molina <tmolina@cablespeed.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
Message-ID: <20031230222403.GA8412@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andy Isaacson <adi@hexapodia.org>,
	Thomas Molina <tmolina@cablespeed.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> <20031230012551.GA6226@k3.hellgate.ch> <Pine.LNX.4.58.0312292031450.6227@localhost.localdomain> <20031230132145.B32120@hexapodia.org> <20031230194051.GD22443@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031230194051.GD22443@holomorphy.com>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Dec 2003 11:40:51 -0800, William Lee Irwin III wrote:
> Thus far interpretations of information collected this way have been
> somewhat lacking. Roger Luethi has identified various points at which
> regressions happened over the course of 2.5, but it appears that
> information hasn't yet been and still needs to be acted on.

My data is interesting for kbuild/efax type work loads and it looks
like bk export might be different. Thomas Molina tested with the patch
I have occasionally posted to revert some VM changes in 2.6.0-test3: No
apparent change in run time (hard to tell for sure since 2.6 increased
variance considerably for some work loads).

I'm not sure how to classify the bk export. It may be the qsbench type
or something new. If it is the former, then 2.5.39 performs a lot worse
than 2.5.38 (and 2.6.0, for that matter).

It would also be interesting to see the numbers for 2.5.27: That's when
physical scanning was introduced -- IMO that performance should be the
minimal goal for 2.6.

Roger
