Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTIXDJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 23:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbTIXDJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 23:09:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53472 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261326AbTIXDJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 23:09:24 -0400
Date: Tue, 23 Sep 2003 19:55:21 -0700
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, bcrl@kvack.org,
       ak@suse.de, iod00d@hp.com, peterc@gelato.unsw.edu.au,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923195521.34299196.davem@redhat.com>
In-Reply-To: <16240.35153.564994.931355@napali.hpl.hp.com>
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
	<20030923102735.42a59d57.davem@redhat.com>
	<16240.35153.564994.931355@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 10:56:33 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> An event that causes a slow-down of 500 times or so is not "normal".

For the slow path of IP option processing it is.  When using IP
embedded in appletalk, it is.

It's all slow path stuff.

Why is this so hard to understand?
