Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbTFLRu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264926AbTFLRu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:50:56 -0400
Received: from air-2.osdl.org ([65.172.181.6]:12233 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264925AbTFLRuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:50:54 -0400
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
From: Andy Pfiffer <andyp@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: christophe@saout.de, adam@yggdrasil.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030612105347.6ea644b7.akpm@digeo.com>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	 <1052510656.6334.8.camel@chtephan.cs.pocnet.net>
	 <1052513725.15923.45.camel@andyp.pdx.osdl.net>
	 <1055369326.1158.252.camel@andyp.pdx.osdl.net>
	 <1055373692.16483.8.camel@chtephan.cs.pocnet.net>
	 <1055377253.1222.8.camel@andyp.pdx.osdl.net>
	 <20030611172958.5e4d3500.akpm@digeo.com>
	 <1055438856.1202.6.camel@andyp.pdx.osdl.net>
	 <20030612105347.6ea644b7.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055441028.1202.11.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Jun 2003 11:03:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 10:53, Andrew Morton wrote:
> Andy Pfiffer <andyp@osdl.org> wrote:
> >
> > Dirty:               0 kB	Dirty:               4 kB <---
> 
> OK.  And are you using initrd as well?

It is specified in lilo.conf (SuSE 8.0 distro) but I don't see any
reason to keep it.  I'll yank it and see if it makes a difference.

Andy


