Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWFUUmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWFUUmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWFUUmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:42:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13991 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750781AbWFUUmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:42:22 -0400
Date: Wed, 21 Jun 2006 13:42:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mattia Dongili <malattia@linux.it>
Cc: hpa@zytor.com, mbligh@mbligh.org, linux-kernel@vger.kernel.org
Subject: Re: fs/binfmt_aout.o, Error: suffix or operands invalid for `cmp'
 [was Re: 2.6.17-mm1]
Message-Id: <20060621134215.1bca6a5c.akpm@osdl.org>
In-Reply-To: <20060621193932.GR24595@inferi.kami.home>
References: <44998DCB.1030703@mbligh.org>
	<20060621184814.GQ24595@inferi.kami.home>
	<44999BC5.7060702@zytor.com>
	<20060621193932.GR24595@inferi.kami.home>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 21:39:32 +0200
Mattia Dongili <malattia@linux.it> wrote:

> Thanks, this is fixed, but I have a new failure:
>   CC [M]  fs/xfs/support/move.o
>   CC [M]  fs/xfs/support/uuid.o
>   LD [M]  fs/xfs/xfs.o
>   CC      fs/dnotify.o
>   CC      fs/dcookies.o
>   LD      fs/built-in.o
>   CC [M]  fs/binfmt_aout.o
> {standard input}: Assembler messages:
> {standard input}:160: Error: suffix or operands invalid for `cmp'
> make[1]: *** [fs/binfmt_aout.o] Error 1
> make: *** [fs] Error 2

what the heck?  Can you do `make fs/binfmt_aout.s' then send the relevant
parts of that file?

