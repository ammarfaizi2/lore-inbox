Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbTIWRko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 13:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTIWRkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 13:40:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1755 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262225AbTIWRkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 13:40:39 -0400
Date: Tue, 23 Sep 2003 10:27:35 -0700
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, bcrl@kvack.org,
       ak@suse.de, iod00d@hp.com, peterc@gelato.unsw.edu.au,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923102735.42a59d57.davem@redhat.com>
In-Reply-To: <16240.24511.375148.520203@napali.hpl.hp.com>
References: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au>
	<20030919043847.GA2996@cup.hp.com>
	<20030919044315.GC7666@wotan.suse.de>
	<16234.36238.848366.753588@wombat.chubb.wattle.id.au>
	<20030919055304.GE16928@wotan.suse.de>
	<20030919064922.B3783@kvack.org>
	<16239.38154.969505.748461@wombat.chubb.wattle.id.au>
	<20030922203629.B21836@kvack.org>
	<20030922232237.28a5ac4a.davem@redhat.com>
	<16240.8965.91289.460763@wombat.chubb.wattle.id.au>
	<20030923035118.578203d5.davem@redhat.com>
	<16240.24511.375148.520203@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 07:59:11 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> The printk() is rate-controlled and doesn't happen for every unaligned
> access.  It's average cost can be made as low as we want to, by adjusting
> the rate.

But if the event is normal, you shouldn't be logging it as if
it weren't.

Anyone who tries to use IP over appletalk or certain protocols
over PPP are going to see your silly messages.

As I understand it, you even do this stupid printk for user apps
as well, that makes it more than rediculious.  I'd be surprised
if anyone can find any useful kernel messages on an ia64 system
in the dmesg output with all the unaligned access crap there.

