Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUAPFGv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 00:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUAPFGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 00:06:51 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:38900 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264936AbUAPFGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 00:06:48 -0500
Date: Thu, 15 Jan 2004 21:06:42 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: Fwd: Re: [2.6] nfs_rename: target $file busy, d_count=2
Message-ID: <20040116050642.GF1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 04:54:57PM -0800, Mike Fedyk wrote:
> On Thu, Jan 15, 2004 at 04:03:46PM -0800, Mike Fedyk wrote:
> > Both client and server are running the same 2.6.1-bk2 kernel with TCP-NFS.
> > SMP, Highmem, & preempt.
> 
> I have four clients that are all having this problem also, three 2.6, and
> one 2.4 client.
> 
> Using TCP-NFS they all have stale nfs handles even after a reboot (only
> rebooted one to try with 2.4.23), but changed one to UDP-NFS, and it didn't
> have the stale handles.
> 
> Will do more testing with UDP-NFS.

No, TCP and UDP NFS both get stale file handles. :(

Can anyone reproduce?


----- End forwarded message -----
