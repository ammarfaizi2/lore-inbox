Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422830AbWJLIht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422830AbWJLIht (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422836AbWJLIht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:37:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45279 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422830AbWJLIhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:37:48 -0400
Date: Thu, 12 Oct 2006 01:37:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitriy Monakhov <dmonakhov@sw.ru>
Cc: Dmitriy Monakhov <dmonakhov@openvz.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>, <devel@openvz.org>,
       ext2-devel@lists.sourceforge.net, Andrey Savochkin <saw@swsoft.com>
Subject: Re: [RFC][PATCH] EXT3: problem with page fault inside a transaction
Message-Id: <20061012013702.fe0515ed.akpm@osdl.org>
In-Reply-To: <87lknmgeaz.fsf@sw.ru>
References: <87mz82vzy1.fsf@sw.ru>
	<20061011234330.efae4265.akpm@osdl.org>
	<87lknmgeaz.fsf@sw.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 11:53:56 +0400
Dmitriy Monakhov <dmonakhov@sw.ru> wrote:

> > With the stuff Nick and I are looking at, we won't take pagefaults inside
> > prepare_write()/commit_write() any more.
> I'sorry may be i've missed something, but how cant you prevent this?

Start here: http://lkml.org/lkml/2006/10/11/12
