Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUCKTYo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUCKTYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:24:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:39851 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261418AbUCKTYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:24:42 -0500
Date: Thu, 11 Mar 2004 11:24:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 bits for remap-file-pages-prot.
Message-Id: <20040311112440.0f72780a.akpm@osdl.org>
In-Reply-To: <20040311190852.GA6887@mschwid3.boeblingen.de.ibm.com>
References: <20040311190852.GA6887@mschwid3.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> I tried 2.6.4-mm1 and found that it wouldn't even compile because
>  of the remap-file-pages-prot changes.

Yup, sorry.   Actually, if you look inside

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4/2.6.4-mm1/broken-out/remap-file-pages-prot-ia64-2.6.4-rc2-mm1-A0.patch

There's a little test app to check the functionality of the new syscall. 
You'll need to tweak the syscall slot number.

