Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVD1IFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVD1IFc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVD1IFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:05:32 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:43975 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261573AbVD1IF0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:05:26 -0400
X-ORBL: [67.124.119.21]
Date: Thu, 28 Apr 2005 01:05:22 -0700
From: Chris Wedgwood <cw@f00f.org>
To: aq <aquynh@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/Kconfig: more consistent configuration of XFS
Message-ID: <20050428080522.GB28101@taniwha.stupidest.org>
References: <9cde8bff050428005528ecf692@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cde8bff050428005528ecf692@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 04:55:48PM +0900, aq wrote:

> Here is the patch to fix the problem: it moves XFS configuration
> from fs/xfs/Kconfig to fs/Kconfig, makes it to do all the
> configuration in the same screen (by removing "menu" directive), and
> removes the unnecessary fs/xfs/Kconfig.

XFS has several more configuration option not in the mainline tree.
Doing this makes keeping things in sync harder.
