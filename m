Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWHDFRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWHDFRf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWHDFRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:17:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30957 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030220AbWHDFRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:17:34 -0400
Date: Thu, 3 Aug 2006 22:17:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Nate Diller" <nate.diller@gmail.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] [3/3] Add the Elevator I/O scheduler
Message-Id: <20060803221727.acf4197d.akpm@osdl.org>
In-Reply-To: <5c49b0ed0608031921o7f140a80g3c4f860e9890186e@mail.gmail.com>
References: <5c49b0ed0608031921o7f140a80g3c4f860e9890186e@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006 19:21:45 -0700
"Nate Diller" <nate.diller@gmail.com> wrote:

> This is the Elevator I/O scheduler.

I stuck this in -mm (after fixing many tens of wordwrapping corruptions).

It does need many coding style fixes sometime.  80-cols, newlines after
`if' statements, macros->commented-inlines, fix a=b=c=d=e=<expr> statements,
etc.  Well-understood stuff.  So we'll need a version 2 sometime, please.  

Meanwhile, what we have here is OK for people to review-n-test.
