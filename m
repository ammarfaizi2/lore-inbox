Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269186AbUIQWHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269186AbUIQWHc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 18:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269066AbUIQWEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 18:04:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:5279 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269034AbUIQWDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 18:03:40 -0400
Date: Fri, 17 Sep 2004 15:07:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: stelian@popies.net, hugh@veritas.com, bruce@andrew.cmu.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-Id: <20040917150715.6b0ec457.akpm@osdl.org>
In-Reply-To: <20040917212847.GC15426@dualathlon.random>
References: <20040917154834.GA3180@crusoe.alcove-fr>
	<Pine.LNX.4.44.0409171708210.3162-100000@localhost.localdomain>
	<20040917205011.GA3049@crusoe.dsnet>
	<20040917212847.GC15426@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@novell.com> wrote:
>
> Thanks Stelian. Now if you like to keep working in this area and you
> would like to also change do_syslog to use your new object, more power
> to you and good luck! 8)

heh, we'll burst his brain.  log_buf has two distinct `out' indices ;)
