Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbVKOTZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbVKOTZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbVKOTZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:25:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59327 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965011AbVKOTZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:25:35 -0500
Date: Tue, 15 Nov 2005 11:25:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, dhowells@redhat.com, linux-kernel@vger.kernel.org,
       linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
       nfsv4@linux-nfs.org
Subject: Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility
Message-Id: <20051115112504.4b645a86.akpm@osdl.org>
In-Reply-To: <11717.1132077542@warthog.cambridge.redhat.com>
References: <20051114150347.1188499e.akpm@osdl.org>
	<dhowells1132005277@warthog.cambridge.redhat.com>
	<Pine.LNX.4.64.0511141428390.3263@g5.osdl.org>
	<11717.1132077542@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> What I'm trying to do is actually fairly simple in concept:
> 
>   (1) Have a metadata inode (imeta) that covers the block device.
> 

Can you remind me again why it requires a blockdev rather than a regular file?

coz people are just going to go and use a loopback mount to get their
blockdev, which is a bit sad.

