Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUF0R5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUF0R5j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 13:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUF0R5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 13:57:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:962 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261169AbUF0R5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 13:57:37 -0400
Date: Sun, 27 Jun 2004 10:52:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: simon@nuit.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot access '/dev/pts/292': Value too large for defined data
 type
Message-Id: <20040627105255.2d6fa530.akpm@osdl.org>
In-Reply-To: <20040627102439.GA32767@nuit.ca>
References: <20040626151108.GA8778@nuit.ca>
	<20040626135948.7b4396e9.akpm@osdl.org>
	<20040627102439.GA32767@nuit.ca>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

simon@nuit.ca wrote:
>
> Ce jour Sat, 26 Jun 2004, Andrew Morton a dit:
> 
> > simon@nuit.ca wrote:
> > 
> > 2.6.7 plus
> > ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.7-bk9.gz
> > would be suitable.
> 
> In file included from include/linux/list.h:8,
>                  from include/linux/signal.h:4,
>                  from arch/ppc/kernel/asm-offsets.c:12:
> include/asm/system.h:85: error: parse error before '{' token
> include/asm/system.h:85: error: parse error before '<' token
> make[2]: *** [arch/ppc/kernel/asm-offsets.s] Error 1
> make[1]: *** [arch/ppc/kernel/asm-offsets.s] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.6'
> make: *** [stamp-kernel-configure] Error 2
> 
> typos somewhere =)
> 

That was fixed - please try -bk10.
