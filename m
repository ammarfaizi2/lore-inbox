Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbTFBMGz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbTFBMGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:06:55 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:31942 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262220AbTFBMGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:06:54 -0400
Date: Mon, 2 Jun 2003 14:19:59 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
Message-ID: <20030602121959.GA20423@wohnheim.fh-wedel.de>
References: <20030530174319.GA16687@wohnheim.fh-wedel.de> <20030530.235505.23020750.davem@redhat.com> <20030531075615.GA25089@wohnheim.fh-wedel.de> <200305311822.21823.kernel@kolivas.org> <20030601012516.GJ23715@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030601012516.GJ23715@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003 20:25:16 -0500, Matt Mackall wrote:
> 
> Timing on jffs2 is notoriously unrepeatable anyway - it's fully log
> structured rather than journalled so it behaves a little differently.

cp jffs2.image /dev/partition_for_jffs2
do_test_1
cp jffs2.image /dev/partition_for_jffs2
do_test_2

No problem, if you know how to deal with it.  And when doing
comparison benchmarks remember to sleep a lot.  Without that, you end
up measuring GC efficiency, which doesn't matter in real life too
much.

Jörn

-- 
To recognize individual spam features you have to try to get into the
mind of the spammer, and frankly I want to spend as little time inside
the minds of spammers as possible.
-- Paul Graham
