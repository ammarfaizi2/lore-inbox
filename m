Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262166AbSJJTRy>; Thu, 10 Oct 2002 15:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262167AbSJJTRy>; Thu, 10 Oct 2002 15:17:54 -0400
Received: from holomorphy.com ([66.224.33.161]:42987 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262166AbSJJTRa>;
	Thu, 10 Oct 2002 15:17:30 -0400
Date: Thu, 10 Oct 2002 12:19:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [LART] inode mismanagement in hugetlb code
Message-ID: <20021010191954.GS10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0210101447390.13421-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210101447390.13421-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 03:00:37PM -0400, Alexander Viro wrote:
> 	a) inodes MUST have an address of valid struct super_block in their
> ->i_sb.  Had been discussed quite a few times already.
> 	b) inodes MUST NOT be allocated by code that isn't called from
> alloc_inode().
> 	c) inodes SHOULD NOT be kept around for noticable intervals without
> a dentry pointing to them.
> 	d) people who choose variable names like htlbpagek SHOULD be sent to
> produce a street map of R'Lyeh.  On site.


A wee bit of neurosurgery is in progress to repair (a) and (b) since
they're taking out my boxen dead cold and reliably on the first or
second invocation with Paul Larson's tests. (c) is very unclean, and
(d) I wholeheartedly agree with (and am amused by the wording of too =).


Bill
