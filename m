Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTIWTFJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTIWTFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:05:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4572 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263422AbTIWTFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:05:00 -0400
Date: Tue, 23 Sep 2003 11:52:00 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andreas Schwab <schwab@suse.de>
Cc: bcrl@kvack.org, tony.luck@intel.com, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, ak@suse.de,
       iod00d@hp.com, peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923115200.1f5b44df.davem@redhat.com>
In-Reply-To: <jehe3372th.fsf@sykes.suse.de>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
	<20030923142925.A16490@kvack.org>
	<jehe3372th.fsf@sykes.suse.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 20:54:50 +0200
Andreas Schwab <schwab@suse.de> wrote:

> Unaligned access are a BUG.

Wrong, they've been allowed in the kernel networking from day
one and there is nothing that can be done to avoid the cases
for which they occur.

Stop spreading fud.
