Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265048AbUHCGLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265048AbUHCGLe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 02:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUHCGLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 02:11:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:2798 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265048AbUHCGLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 02:11:31 -0400
Date: Mon, 2 Aug 2004 23:09:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Justin Guyett <justin-lkml@soze.net>
Cc: linux-kernel@vger.kernel.org, Hibbard.Smith@nasdaq.com
Subject: Re: mainline i2o issues with adaptec raid (was: i2o and adaptec
 raid)
Message-Id: <20040802230931.04c0769d.akpm@osdl.org>
In-Reply-To: <20040803050223.GB2295@arion.soze.net>
References: <20040803050223.GB2295@arion.soze.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Guyett <justin-lkml@soze.net> wrote:
>
>  I just started toying with an adaptec i2o card, an Adaptec 2110s, and
>  for random reads and writes bonnie++ shows that the i2o driver is
>  somewhat slower than the dpt_i2o driver.

By reading your .config I was able to divine that you're running some 2.6
kernel ;)

There's an i2o rewrite in
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2.6.8-rc2-mm2/2.6.8-rc2-mm2.gz
- testing of that would be appreciated.

