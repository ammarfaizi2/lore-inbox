Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272265AbTG3VwQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272280AbTG3VwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:52:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:39839 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272265AbTG3VvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:51:16 -0400
Date: Wed, 30 Jul 2003 14:39:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: thornber@sistina.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: dm: v4 ioctl interface (was: Re: Linux v2.6.0-test2)
Message-Id: <20030730143933.5f8d1ba4.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.21.0307302314370.29569-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0307271003360.3401-100000@home.osdl.org>
	<Pine.GSO.4.21.0307302314370.29569-100000@vervain.sonytel.be>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> >   o dm: v4 ioctl interface
> 
> This interface code contains a local `resume()' routine, which conflicts with
> the `resume()' defined by many architectures in <asm/*.h>. The patch below
> fixes this by renaming the local routine to `do_resume()'.

ok..

> However, after this change it still doesn't compile...

It does for me.  What is it doing wrong for you?
