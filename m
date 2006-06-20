Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbWFTH1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbWFTH1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 03:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbWFTH1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 03:27:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2947 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965117AbWFTH1M (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 03:27:12 -0400
Date: Tue, 20 Jun 2006 00:26:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: dgc@sgi.com, vs@namesys.com, hch@infradead.org, Reiserfs-Dev@namesys.com,
       Linux-Kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: batched write
Message-Id: <20060620002659.08aee963.akpm@osdl.org>
In-Reply-To: <4497A17C.50804@namesys.com>
References: <20060524175312.GA3579@zero>
	<44749E24.40203@namesys.com>
	<20060608110044.GA5207@suse.de>
	<1149766000.6336.29.camel@tribesman.namesys.com>
	<20060608121006.GA8474@infradead.org>
	<1150322912.6322.129.camel@tribesman.namesys.com>
	<20060617100458.0be18073.akpm@osdl.org>
	<20060619162740.GA5817@schatzie.adilger.int>
	<4496D606.8070402@namesys.com>
	<20060619185049.GH5817@schatzie.adilger.int>
	<20060620000133.GB8770394@melbourne.sgi.com>
	<4497A17C.50804@namesys.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 00:19:24 -0700
Hans Reiser <reiser@namesys.com> wrote:

> So far we have XFS, FUSE, and reiser4 benefiting from the potential
> ability to process more than 4k at a time.  Is it enough?

Spose so.  Let's see what the diff looks like?
