Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVB0KcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVB0KcP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 05:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVB0KcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 05:32:15 -0500
Received: from fire.osdl.org ([65.172.181.4]:54214 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261292AbVB0KcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 05:32:12 -0500
Date: Sun, 27 Feb 2005 02:31:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: <stone_wang@sohu.com>
Cc: riel@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux-2.6.11-rc5: kernel/sys.c setrlimit() RLIMIT_RSS
 cleanup
Message-Id: <20050227023136.0d1528a7.akpm@osdl.org>
In-Reply-To: <17855236.1109499454066.JavaMail.postfix@mx20.mail.sohu.com>
References: <17855236.1109499454066.JavaMail.postfix@mx20.mail.sohu.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<stone_wang@sohu.com> wrote:
>
> $ ulimit  -m 100000
>  bash: ulimit: max memory size: cannot modify limit: Function not implemented

I don't know about this.  The change could cause existing applications and
scripts to fail.  Sure, we'll do that sometimes but this doesn't seem
important enough.
