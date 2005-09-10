Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVIJLnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVIJLnl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 07:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVIJLnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 07:43:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26499 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbVIJLnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 07:43:41 -0400
Date: Sat, 10 Sep 2005 04:42:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: awesley@acquerra.com.au
Cc: nate.diller@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.13 buffer strangeness - ext2/3/reiser4/xfs
 comparison
Message-Id: <20050910044240.4e8e8e03.akpm@osdl.org>
In-Reply-To: <4322B437.3010309@acquerra.com.au>
References: <432151B0.7030603@acquerra.com.au>
	<EXCHG2003Zi71mrvoGd00000659@EXCHG2003.microtech-ks.com>
	<5c49b0ed05090914394dba42bf@mail.gmail.com>
	<432225E0.9030606@acquerra.com.au>
	<5c49b0ed0509091735436260bb@mail.gmail.com>
	<432231B7.2060200@acquerra.com.au>
	<5c49b0ed0509091847135834c0@mail.gmail.com>
	<432243AA.4000508@acquerra.com.au>
	<5c49b0ed05090922021b8f8112@mail.gmail.com>
	<4322B437.3010309@acquerra.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Wesley <awesley@acquerra.com.au> wrote:
>
> I compared ext2,ext3,xfs,vfat,reiser and reiser4.
> 
>  The hands-down winner was ext2. All the others showed problems of either lower disk throughput
>  or dropped frames during video capture.

ext2 is a good filesystem.  For that sort of application all the journaling
gunk can really get in the way.

You should have tested ext3 with data=writeback.
