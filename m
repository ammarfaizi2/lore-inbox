Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269653AbUICMI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269653AbUICMI2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269667AbUICMI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:08:28 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:49576 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269653AbUICMGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:06:41 -0400
Message-ID: <2c6b3ab004090305061c6f1a59@mail.gmail.com>
Date: Fri, 3 Sep 2004 17:36:40 +0530
From: Amit Gud <amitgud@gmail.com>
Reply-To: Amit Gud <amitgud@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: Using filesystem blocks
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org, gud@eth.net
In-Reply-To: <20040903091926.B2288@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2c6b3ab004090212293b394b41@mail.gmail.com> <20040902200743.GB6875@taniwha.stupidest.org> <2c6b3ab0040902215656704680@mail.gmail.com> <20040903091926.B2288@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > First up, why is mbcache code is written at VFS layer than being
> > filesystem specific? Neccessarily to take away the coding overheads of
> > maintaining block cache that any filesystem uses, even though given
> > that only ext2 and ext3 uses it. It facilitates code reuse.
> 
> It is not written at the VFS level.  It's a library ontop of the buffercache
> than can be reused by filesystems.
> 

Nice to know this. But intent of my mail is not affected by this in a major way.

AG
