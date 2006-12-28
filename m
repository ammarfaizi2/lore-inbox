Return-Path: <linux-kernel-owner+w=401wt.eu-S1753098AbWL1KcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbWL1KcK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754806AbWL1KcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:32:09 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:38232 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753098AbWL1KcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:32:08 -0500
X-Sasl-enc: czvd95Jf3DbkStiHxBFc+wcvW0SIJTUxR53QF5NmxsvU 1167301856
Date: Thu, 28 Dec 2006 19:32:26 +0900 (WST)
From: Ian Kent <raven@themaw.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       nfs@lists.sourceforge.net
Subject: Re: VFS: Busy inodes after unmount. Self-destruct in 5 seconds. 
 Have a nice day...
In-Reply-To: <200612281027.09783.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64.0612281930120.5917@raven.themaw.net>
References: <200612281027.09783.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006, Jesper Juhl wrote:

> 
> I get this message in my webservers (with NFS mounted homedirs) logs once 
> in a while : 
> 
>   kernel: VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
> 
> It doesn't seem to have any bad effect on anything, but it would be nice 
> to know if there is any cause for concern.

It's at least a memory leak.

> 
> The NFS server is running 2.6.18.1 and the webservers are running 2.6.17.8

Strange, I've not heard of this message appearing for a long time now.

Ian

