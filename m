Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265903AbTGIJ5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbTGIJ5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:57:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:34772 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265903AbTGIJ5J (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:57:09 -0400
Date: Wed, 9 Jul 2003 03:12:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: [PATCH] 2/5 VM changes: skip-writepage.patch
Message-Id: <20030709031209.46863a29.akpm@osdl.org>
In-Reply-To: <16139.54921.640901.797268@laputa.namesys.com>
References: <16139.54921.640901.797268@laputa.namesys.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> wrote:
>
> Don't call ->writepage from VM scanner when page is met for the first time
>  during scan.

Makes sense, needs testing with a lot wider workloads.  I'll take a look.


