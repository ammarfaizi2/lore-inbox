Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272264AbTG3WVZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272276AbTG3WVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:21:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:14002 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272264AbTG3WUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:20:47 -0400
Date: Wed, 30 Jul 2003 15:09:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2+ext3+dbench=Buffer I/O error
Message-Id: <20030730150902.5281f72c.akpm@osdl.org>
In-Reply-To: <5.2.1.1.2.20030730163933.00b41b50@wen-online.de>
References: <5.2.1.1.2.20030730163933.00b41b50@wen-online.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> wrote:
>
> Greetings,
> 
> While trying to duplicate Randy Hron's "dbench has intermittent hang on 
> 2.6.0-test1-ac2" report, I received quite a few "Buffer I/O error on 
> /dev/hda8, logical block N" messages.  (changing elevators makes no 
> difference fwiw).

That's just a gremlinlet.  You can delete the offending printk for now.

> I went back to test1, and it spat up a couple of "buffer 
> layer error" messages and associated traces.   Attempting to umount 
> afterward to run fsck left umount in D state.  See attachment.

Well that's a worry.  Is it repeatable?
