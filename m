Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbTIWXsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 19:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTIWXsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 19:48:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8671 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263439AbTIWXsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 19:48:37 -0400
Date: Tue, 23 Sep 2003 16:35:32 -0700
From: "David S. Miller" <davem@redhat.com>
To: Ian Wienand <ianw@gelato.unsw.edu.au>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923163532.7d133527.davem@redhat.com>
In-Reply-To: <20030923230412.GA30157@cse.unsw.EDU.AU>
References: <16234.36238.848366.753588@wombat.chubb.wattle.id.au>
	<20030919055304.GE16928@wotan.suse.de>
	<20030919064922.B3783@kvack.org>
	<16239.38154.969505.748461@wombat.chubb.wattle.id.au>
	<20030922203629.B21836@kvack.org>
	<20030922232237.28a5ac4a.davem@redhat.com>
	<16240.8965.91289.460763@wombat.chubb.wattle.id.au>
	<20030923035118.578203d5.davem@redhat.com>
	<16240.24511.375148.520203@napali.hpl.hp.com>
	<20030923102735.42a59d57.davem@redhat.com>
	<20030923230412.GA30157@cse.unsw.EDU.AU>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Sep 2003 09:04:12 +1000
Ian Wienand <ianw@gelato.unsw.edu.au> wrote:

> Just as a point of interest, as an application programmer I think it's
> the type of thing you want to know about quite loudly.

Sure, and I agree that you should have the choice to see
these messages at the verbosity you desire, and ia64 has
the capability to control things in this way.

What I disagree with is spitting out log messages about such things
happening in the kernel.  Because that is remotely triggerable.  As
Alan mentioned, if I can send packets to your ia64 box I can make it
spew system log messages.

