Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbUBPQmb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 11:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUBPQmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 11:42:31 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:39105 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265692AbUBPQm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 11:42:29 -0500
Subject: Re: kthread vs. dm-daemon (was: Oopsing cryptoapi (or loop
	device?) on 2.6.*)
From: Christophe Saout <christophe@saout.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Joe Thornber <thornber@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1076938020.7350.18.camel@leto.cs.pocnet.net>
References: <20040216034250.EDCC82C053@lists.samba.org>
	 <1076938020.7350.18.camel@leto.cs.pocnet.net>
Content-Type: text/plain
Message-Id: <1076949740.12156.0.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 17:42:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 16.02.2004 schrieb Christophe Saout um 14:27:

> > Yes, looks like dm-daemon is a workqueue.
> 
> The only small difference is that you don't need a work_struct and the
> work function is only called once, if there is work. The work function
> has process all the work that has been queued.

Forget that. I'm justing seeing that you can do this when using a
work_struct as notifier. Cool. :)


