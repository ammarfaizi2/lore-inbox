Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271038AbTGQVsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271578AbTGQVsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:48:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:38878 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271038AbTGQVrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:47:42 -0400
Date: Thu, 17 Jul 2003 14:55:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: miquels@cistron.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-Id: <20030717145507.3ce5042c.akpm@osdl.org>
In-Reply-To: <20030717131955.D2302@pclin040.win.tue.nl>
References: <20030716184609.GA1913@kroah.com>
	<20030717014410.A2026@pclin040.win.tue.nl>
	<20030716164917.2a7a46f4.akpm@osdl.org>
	<20030717122600.A2302@pclin040.win.tue.nl>
	<bf5uqb$3ei$1@news.cistron.nl>
	<20030717131955.D2302@pclin040.win.tue.nl>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> wrote:
>
> > The filesystem driver itself must convert from native rdev to linux 32:32.
> 
> Look at the mknod utility.
> The user types major,minor.
> The system call uses dev_t.
> This means that user space needs to be able to combine
> major,minor into a dev_t.

But mknod64() takes major/minor.  Requiring a util-linux upgrade is OK.

