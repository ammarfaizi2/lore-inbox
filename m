Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbTI3Mcg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbTI3Mcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:32:36 -0400
Received: from rth.ninka.net ([216.101.162.244]:14211 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261420AbTI3Mce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:32:34 -0400
Date: Tue, 30 Sep 2003 05:32:24 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: ast@domdv.de, schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-Id: <20030930053224.030101c5.davem@redhat.com>
In-Reply-To: <20030930122137.GN2908@suse.de>
References: <200309301144.h8UBiUUF004315@burner.fokus.fraunhofer.de>
	<20030930115411.GL2908@suse.de>
	<3F797316.2010401@domdv.de>
	<20030930122137.GN2908@suse.de>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003 14:21:37 +0200
Jens Axboe <axboe@suse.de> wrote:

> I will tell you to talk to the glibc folks, because that's where your
> problem is.

I think it's totally unreasonable to expect the glibc folks
to suck in every single new weird API that ends up in the kernel.

Part of this is our job.

But until we have that bit solved, it's irresonsible of us to tell
users to go scream at the glibc people.  Rather, we should fix the
(really, honestly, incredibly minor) things that prevent these kernel
header files from working for users.
