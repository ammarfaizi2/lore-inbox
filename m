Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUHPBBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUHPBBm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 21:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267311AbUHPBBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 21:01:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:11460 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267306AbUHPBBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 21:01:41 -0400
Date: Sun, 15 Aug 2004 17:59:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, mochel@digitalimplant.org,
       benh@kernel.crashing.org, david-b@pacbell.net
Subject: Re: [patch] enums to clear suspend-state confusion
Message-Id: <20040815175949.19d03e7f.akpm@osdl.org>
In-Reply-To: <20040812120220.GA30816@elf.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> +enum pci_state {
>  +	D0 = 0,
>  +	D1 = 1,
>  +	D2 = 2,

These symbols are too generic.  They don't appear to currently clash with
anything else, but they could.
