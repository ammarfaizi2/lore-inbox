Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264880AbUGGEXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbUGGEXX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 00:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264895AbUGGEXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 00:23:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:3241 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264880AbUGGEXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 00:23:22 -0400
Date: Tue, 6 Jul 2004 21:22:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brad Fitzpatrick <brad@danga.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs_inode_cache not getting pruned
Message-Id: <20040706212218.5ef9556d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.55.0407062045200.24800@danga.com>
References: <Pine.LNX.4.55.0407062045200.24800@danga.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Fitzpatrick <brad@danga.com> wrote:
>
> I've got a couple boxes here that keep running out of lowmem after about a
>  day of uptime, rendering them almost entirely unusable.  (OOM killer
>  taking out processes left and right, despite 1.5 GB highmem available...)
> 
>  From what I can tell, nfs_inode_cache isn't responding to memory pressure
>  and cleaning itself (enough?).

It works OK here.  Please provide kernel version and full NFS mount options.
