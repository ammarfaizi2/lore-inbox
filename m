Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbVIBFeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbVIBFeb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 01:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbVIBFeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 01:34:31 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:14525 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP
	id S1750875AbVIBFeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 01:34:31 -0400
X-ORBL: [67.124.117.85]
Date: Thu, 1 Sep 2005 22:33:56 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050902053356.GA20603@taniwha.stupidest.org>
References: <20050902003915.GI3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050902003915.GI3657@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 02:39:15AM +0200, Adrian Bunk wrote:

> 4Kb kernel stacks are the future on i386, and it seems the problems
> it initially caused are now sorted out.

Not entirely.

XFS when mixed with raid/lvm/nfs still blows up.  It's probably not
alone in this respect but worse than ext2/3.
