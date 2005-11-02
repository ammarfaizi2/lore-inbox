Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932665AbVKBIyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbVKBIyX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 03:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbVKBIyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 03:54:23 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:156 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932665AbVKBIyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 03:54:22 -0500
Date: Wed, 02 Nov 2005 17:45:04 +0900 (JST)
Message-Id: <20051102.174504.83606193.taka@valinux.co.jp>
To: clameter@engr.sgi.com
Cc: rob@landley.net, akpm@osdl.org, torvalds@osdl.org, kravetz@us.ibm.com,
       raybry@mpdtxmail.amd.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, haveblue@us.ibm.com, magnus.damm@gmail.com,
       pj@sgi.com, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 0/5] Swap Migration V5: Overview
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <Pine.LNX.4.62.0511020030210.19157@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0511010943310.16224@schroedinger.engr.sgi.com>
	<20051102.143047.35521963.taka@valinux.co.jp>
	<Pine.LNX.4.62.0511020030210.19157@schroedinger.engr.sgi.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

> > > > > Do you think the features which these patches add should be Kconfigurable?
> > 
> > This code looks no help for hot-remove. It seems able to handle only
> > pages easily to migrate, while hot-remove has to guarantee all pages
> > can be migrated.
> 
> Right.
> 
> > Hi Christoph, sorry I've been off from lhms for long time.
> > 
> > Shall I port the generic memory migration code for hot-remove to -mm tree
> > directly, and add some new interface like migrate_page_to(struct page *from,
> > struct page *to) so this may probably fit for your purpose.
> > 
> > The code is still in Dave's mhp1 tree waiting for being merged to -mm tree.
> > The port will be easy because the migration code is independent to the
> > memory hotplug code. The core code isn't so big.
> 
> Please follow the discussion on lhms-devel. I am trying to bring these two 
> things together.

OK, I'll look over it.

Thanks.
