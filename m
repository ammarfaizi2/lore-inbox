Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUFSSzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUFSSzg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 14:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUFSSzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 14:55:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:47068 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262538AbUFSSze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 14:55:34 -0400
Date: Sat, 19 Jun 2004 11:54:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: FabF <fabian.frederick@skynet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.7] ext3 s_dirt for r/w
Message-Id: <20040619115438.765da1c0.akpm@osdl.org>
In-Reply-To: <1087668287.2472.4.camel@localhost.localdomain>
References: <1087668287.2472.4.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF <fabian.frederick@skynet.be> wrote:
>
> 	Here is a patch setting s_dirt for read-write filesystems in ext3_init
>  (doing it in create_journal seems troublesome IMHO).

Why?

>  PS: untested

Please don't send untested patches.

>  diff -Naur orig/fs/super.c edited/fs/super.c
>  --- orig/fs/super.c	2004-06-16 07:20:03.000000000 +0200
>  +++ edited/fs/super.c	2004-06-19 19:58:19.895637880 +0200

fs/super.c does not contain ext3 code.
