Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbTDEW5y (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 17:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbTDEW5y (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 17:57:54 -0500
Received: from [12.47.58.55] ([12.47.58.55]:43409 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262711AbTDEW5w (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 17:57:52 -0500
Date: Sat, 5 Apr 2003 15:10:25 -0800
From: Andrew Morton <akpm@digeo.com>
To: azarah@gentoo.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Slab corruption with ext3-handle-cache.patch
Message-Id: <20030405151025.249b261e.akpm@digeo.com>
In-Reply-To: <1049582687.29758.11.camel@nosferatu.lan>
References: <1049580790.29758.8.camel@nosferatu.lan>
	<20030405143852.67833364.akpm@digeo.com>
	<1049582687.29758.11.camel@nosferatu.lan>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Apr 2003 23:09:17.0926 (UTC) FILETIME=[6231D860:01C2FBC8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer <azarah@gentoo.org> wrote:
>
> > Do you have CONFIG_EXT3_FS_POSIX_ACL enabled?
> 
> Nope.

So we're leaving an inode on the orphan list.  I wonder why that started
happening.  Thanks.

