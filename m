Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbTJTUKU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 16:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTJTUKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 16:10:20 -0400
Received: from [65.172.181.6] ([65.172.181.6]:20928 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262695AbTJTUKR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 16:10:17 -0400
Date: Mon, 20 Oct 2003 13:10:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: ramon.rey@hispalinux.es
Cc: rrey@ranty.pantax.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [BUG] Re: 2.6.0-test8-mm1
Message-Id: <20031020131008.19125b7c.akpm@osdl.org>
In-Reply-To: <1066677679.2121.3.camel@debian>
References: <20031020020558.16d2a776.akpm@osdl.org>
	<1066677679.2121.3.camel@debian>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ramón Rey Vicente <rrey@ranty.pantax.net> wrote:
>
> The same problem with other kernel versions. I get it trying to delete
> my local 2.6 svn repository:
> 
> EXT3-fs error (device hdb1): ext3_free_blocks: Freeing blocks in system
> zones - Block = 512, count = 1

This is consistent with a corrupted filesystem.  Have you forced a fsck
against that partition?

