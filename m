Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbTIEDnN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 23:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbTIEDnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 23:43:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:61827 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261360AbTIEDnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 23:43:12 -0400
Date: Thu, 4 Sep 2003 20:44:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm5 dbench stuck in D state
Message-Id: <20030904204403.645b7a29.akpm@osdl.org>
In-Reply-To: <20030905023813.GA29171@rushmore>
References: <20030905023813.GA29171@rushmore>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
>
> Uniprocessor x86 ext2 on IDE system running 2.6.0-test4-mm5
>  has dbench stuck in uninterruptible sleep.

Yes, sorry.  More dodgy Australian software I'm afraid.  You'll need to
revert

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm5/broken-out/elv-insertion-fix.patch

That patch is in Linus's tree now, so it should be a nice test of our bug
reporting processes.  Sigh.

