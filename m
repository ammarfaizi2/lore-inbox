Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWDTWux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWDTWux (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWDTWux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:50:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42409 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932107AbWDTWuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:50:52 -0400
Date: Thu, 20 Apr 2006 15:49:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [Patch: 001/006] pgdat allocation for new node add (specify
 node id)
Message-Id: <20060420154956.1aa4acbe.akpm@osdl.org>
In-Reply-To: <20060420190338.EE4A.Y-GOTO@jp.fujitsu.com>
References: <20060420185123.EE48.Y-GOTO@jp.fujitsu.com>
	<20060420190338.EE4A.Y-GOTO@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
>
> +int add_memory(int nid, u64 start, u64 size)
>  +{
>  +	int ret;
>  +
>  +	/* call arch's memory hotadd */
>  +	ret = arch_add_memory(nid, start, size;
>  +
>  +	return ret;
>  +}

So this patch is missing a ), but your later patch which touches this code
actually has the ).  Which tells me that this isn't the correct version of
this patch.

I'll fix that all up, but I would ask you to carefully verify that the
patches which I merged are the ones which you meant to send, thanks.

