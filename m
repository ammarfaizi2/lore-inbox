Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUJ0AUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUJ0AUE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUJ0AUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:20:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:24231 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261604AbUJ0AT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:19:59 -0400
Date: Tue, 26 Oct 2004 17:23:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] remove highmem_start_page
Message-Id: <20041026172359.3059edec.akpm@osdl.org>
In-Reply-To: <1098820614.5633.3.camel@localhost>
References: <1098820614.5633.3.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
> +static inline int page_is_highmem(struct page *page)
> +{
> +	return PageHighMem(page);
> +}

(boggle).  Why not just use PageHighMem() directly?
