Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVAaKxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVAaKxb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 05:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVAaKxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 05:53:31 -0500
Received: from mx1.mail.ru ([194.67.23.121]:29056 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261847AbVAaKxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 05:53:19 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
Date: Mon, 31 Jan 2005 13:52:57 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200501311352.57234.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 01:34:59 -0600, Matt Mackall wrote:

> This patch adds a generic array sorting library routine. This is meant
> to replace qsort, which has two problem areas for kernel use.

> --- /dev/null
> +++ mm2/include/linux/sort.h
> @@ -0,0 +1,8 @@

> +void sort(void *base, size_t num, size_t size,
> +	  int (*cmp)(const void *, const void *),
> +	  void (*swap)(void *, void *, int));

extern void sort(...) ?

	Alexey

P. S.: Andrew's email ends with ".org".
