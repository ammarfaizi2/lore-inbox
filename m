Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263101AbUEQXRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUEQXRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUEQXRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:17:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:55502 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263101AbUEQXRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:17:10 -0400
Date: Mon, 17 May 2004 16:19:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Robert M. Stockmann" <stock@stokkie.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ramdisk driver in 2.6.6 has a severe bug
Message-Id: <20040517161943.37d826a3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0405180049040.20775-100000@hubble.stokkie.net>
References: <Pine.LNX.4.44.0405180049040.20775-100000@hubble.stokkie.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert M. Stockmann" <stock@stokkie.net> wrote:
>
> So basicly i copied all my files from rootmdk92 to the new rootmdk100 ramdisk.
> But after copying them and umounting the old ramdisk (rootmdk92) en deleting
>  /dev/loop0 , /dev/loop1 (which is /tmp/rootmdk100) loses all its contents.

ramdisks currently lose contents across umount.  I'm planning on getting it fixed
by 2.6.7.
