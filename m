Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVCXXjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVCXXjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 18:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVCXXjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 18:39:54 -0500
Received: from fire.osdl.org ([65.172.181.4]:23965 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261203AbVCXXiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 18:38:14 -0500
Date: Thu, 24 Mar 2005 15:38:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bill Nottingham <notting@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bad caching behavior in 2.6.12rc1
Message-Id: <20050324153813.5ee0ab1f.akpm@osdl.org>
In-Reply-To: <20050324232731.GA14812@nostromo.devel.redhat.com>
References: <20050324232731.GA14812@nostromo.devel.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Nottingham <notting@redhat.com> wrote:
>
> When I upgraded from 2.6.11 to 2.6.12rc1, the VM started
> behaving really badly with respect to caching.
> 
> Test box is a 1.5GB laptop.
> 
> In typical use, I would open a mailbox A, and then switch
> to mailbox B. Immediately switching back to mailbox A, I
> would find out it was no longer cached. (Using maildirs,
> FWIW.)
> 
> Looking at /proc/meminfo, I would see:
> 
> LowFree: 8-12MB
> HighFree: 300-400MB
> Cached: 100-200MB
> 
> i.e., it was evicting cache when there was plenty of highmem
> available for use.

Where's the rest of the memory gone?  A full /proc/meminfo would be useful.

