Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751870AbWCEGai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbWCEGai (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 01:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbWCEGai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 01:30:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15792 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751870AbWCEGah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 01:30:37 -0500
Date: Sat, 4 Mar 2006 22:28:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mattia Dongili <malattia@linux.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm2
Message-Id: <20060304222856.608f7620.akpm@osdl.org>
In-Reply-To: <20060304172939.GA3915@inferi.kami.home>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
	<20060304172939.GA3915@inferi.kami.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattia Dongili <malattia@linux.it> wrote:
>
> On Fri, Mar 03, 2006 at 04:56:51AM -0800, Andrew Morton wrote:
>  > 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/
> 
>  I just got this one:
> 
>  [ 1865.676000] BUG: unable to handle kernel NULL pointer dereference at virtual address 0000003c

There's some random memory scribbling going on.  It hits me about once per
thirty boots, so I'm bisection-searching ~1400 patches at two hours per
iteration.  It's fascinating stuff.

