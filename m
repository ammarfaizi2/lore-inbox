Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265488AbUAPFG3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 00:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265500AbUAPFG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 00:06:29 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:22771 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265488AbUAPFG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 00:06:28 -0500
Date: Thu, 15 Jan 2004 21:06:13 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Re: [2.6] nfs_rename: target $file busy, d_count=2
Message-ID: <20040116050613.GE1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 04:03:46PM -0800, Mike Fedyk wrote:
> Both client and server are running the same 2.6.1-bk2 kernel with TCP-NFS.
> SMP, Highmem, & preempt.

I have four clients that are all having this problem also, three 2.6, and
one 2.4 client.

Using TCP-NFS they all have stale nfs handles even after a reboot (only
rebooted one to try with 2.4.23), but changed one to UDP-NFS, and it didn't
have the stale handles.

Will do more testing with UDP-NFS.

Mike


----- End forwarded message -----
