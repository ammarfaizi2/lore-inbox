Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161249AbWASINe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161249AbWASINe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 03:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbWASINd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 03:13:33 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:65506
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161249AbWASINd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 03:13:33 -0500
Date: Thu, 19 Jan 2006 00:09:11 -0800 (PST)
Message-Id: <20060119.000911.72978565.davem@davemloft.net>
To: akpm@osdl.org
Cc: trond.myklebust@fys.uio.no, sfr@canb.auug.org.au, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch
 removed from -mm tree
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060118230227.5e761d27.akpm@osdl.org>
References: <20060118.223629.100108404.davem@davemloft.net>
	<1137653279.27267.15.camel@lade.trondhjem.org>
	<20060118230227.5e761d27.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 18 Jan 2006 23:02:27 -0800

> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> >
> > On Wed, 2006-01-18 at 22:36 -0800, David S. Miller wrote:
> >  > I wish there were an exception for function prototypes and definitions.
> >  > Why?  So grep actually works.
> > 
> >  Seconded!
> 
> hm.  Why not use $EDITOR's ctags/etags/etc?

Why rebuild that every time the tree changes when we have
grep and "git grep" which sees updates automatically? :-)
