Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265807AbUA1AA6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 19:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbUA1AA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 19:00:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:31943 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265807AbUA1AA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 19:00:56 -0500
Date: Tue, 27 Jan 2004 16:02:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: tao@debian.org, theman@josephdwagner.info, ak@suse.de,
       rmps@joel.ist.utl.pt, linux-kernel@vger.kernel.org
Subject: Re: RFC: Trailing blanks in source files
Message-Id: <20040127160214.69850c9c.akpm@osdl.org>
In-Reply-To: <20040127111824.7f76efe6.rddunlap@osdl.org>
References: <Pine.LNX.4.58.0401271544120.27260@joel.ist.utl.pt.suse.lists.linux.kernel>
	<p73bropfdgl.fsf@nielsen.suse.de>
	<200401271251.34926.theman@josephdwagner.info>
	<20040127191358.GI20879@khan.acc.umu.se>
	<20040127111824.7f76efe6.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> So please don't bother with just whitespace changes unless you
> are going to cleanup a <driver | fs | module | etc> completely.

And if you're going to do that, do the whitespace cleanup _first_, so the
substantive changes to the driver/fs/module/etc can be sanely understood
and reverted if necessary.

I frequently sneakily remove all newly-added trailing whitespace from the
patches people send me.  In 15 years it'll all be gone.

