Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUGFVVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUGFVVs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 17:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbUGFVVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 17:21:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:32973 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264561AbUGFVVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 17:21:45 -0400
Date: Tue, 6 Jul 2004 14:23:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com, torvalds@osdl.org,
       agk@redhat.com, jim.houston@comcast.net
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
Message-Id: <20040706142335.14efcfa4.akpm@osdl.org>
In-Reply-To: <200407061323.27066.kevcorry@us.ibm.com>
References: <200407011035.13283.kevcorry@us.ibm.com>
	<200407021233.09610.kevcorry@us.ibm.com>
	<20040702124218.0ad27a85.akpm@osdl.org>
	<200407061323.27066.kevcorry@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry <kevcorry@us.ibm.com> wrote:
>
> After talking with Alasdair a bit, there might be one bug in the "dm-use-idr"
> patch I submitted before. It seems (based on some comments in lib/idr.c) that
> the idr_find() routine might not return NULL if the desired ID value is not
> in the tree.


Confused.  idr_find() returns the thing it found, or NULL.  To which
comments do you refer?
