Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264354AbTDXA2k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264355AbTDXA2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:28:39 -0400
Received: from [12.47.58.232] ([12.47.58.232]:15297 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264354AbTDXA2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:28:38 -0400
Date: Wed, 23 Apr 2003 17:38:37 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: ncunningham@clear.net.nz, cat@zip.com.au, pavel@ucw.cz, mbligh@aracnet.com,
       gigerstyle@gmx.ch, geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-Id: <20030423173837.08202f0b.akpm@digeo.com>
In-Reply-To: <20030423172628.0f71ab64.rddunlap@osdl.org>
References: <1051136725.4439.5.camel@laptop-linux>
	<1584040000.1051140524@flay>
	<20030423235820.GB32577@atrey.karlin.mff.cuni.cz>
	<20030423170759.2b4e6294.akpm@digeo.com>
	<20030424001733.GB678@zip.com.au>
	<1051143408.4305.15.camel@laptop-linux>
	<20030423172628.0f71ab64.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Apr 2003 00:40:41.0309 (UTC) FILETIME=[21FB30D0:01C309FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> That may be simple for you, but for lots of users, adding a partition
> (to a ususally full disk drive) isn't simple.  It means backups,
> shrink a filesystem, shrink a partition, add a partition, and run
> mkswap on it.   Yes, the latter 2 are simple, but the former ones
> are not.

Yeah.  swsusp is pretty much the only reason why you would want to have a
swap partition at all in a 2.5/2.6 kernel.

