Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264068AbUDQXaa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 19:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264074AbUDQXaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 19:30:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:31380 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264068AbUDQXa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 19:30:29 -0400
Date: Sat, 17 Apr 2004 16:30:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] lockfs - vfs bits
Message-Id: <20040417163007.67d23c10.akpm@osdl.org>
In-Reply-To: <20040417220632.GA2573@lst.de>
References: <20040417220632.GA2573@lst.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
>  These are the generic lockfs bits.  Basically it takes the XFS freezing
>  statemachine into the VFS.  It's all behind the kernel-doc documented
>  freeze_bdev and thaw_bdev interfaces.

Do we expect to see snapshotting patches for other filesystems arise as a
result of this?

