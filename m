Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTFKJMb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 05:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264248AbTFKJMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 05:12:31 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:44210 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264246AbTFKJMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 05:12:30 -0400
Date: Wed, 11 Jun 2003 02:27:00 -0700
From: Andrew Morton <akpm@digeo.com>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm8
Message-Id: <20030611022700.1ae8fd8b.akpm@digeo.com>
In-Reply-To: <3EE6F3B7.9040809@gts.it>
References: <20030611013325.355a6184.akpm@digeo.com>
	<3EE6F3B7.9040809@gts.it>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2003 09:26:13.0136 (UTC) FILETIME=[803E2900:01C32FFB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Rivoir <s.rivoir@gts.it> wrote:
>
> Andrew Morton wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm8/
> 
> arch/i386/kernel/setup.c: In function 'setup_early_printk':
> arch/i386/kernel/setup.c:919: error: invalid lvalue in unary '&'
> make[1]: *** [arch/i386/kernel/setup.o] Error 1
> 

That patch came from a person at IBM, where blissful unawareness of
single-processor machines is rampant :)

Thanks, will fix.


Meanwhile,  CONFIG_DEBUG_EARLY_PRINTK=n
