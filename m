Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267293AbUHIVvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267293AbUHIVvV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267294AbUHIVvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:51:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:64689 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267293AbUHIVtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:49:01 -0400
Date: Mon, 9 Aug 2004 14:52:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Subject: Re: -mm swsusp: fix highmem handling
Message-Id: <20040809145226.366715e3.akpm@osdl.org>
In-Reply-To: <20040809124825.GA602@elf.ucw.cz>
References: <20040809124825.GA602@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> This fixes highmem handling, and adds some comments so that others do
> not fall into the same trap I fallen in: code does not continue below
> swsusp_arch_resume if things go okay.

Actually these changes seem to be in Pat's tree already.  Please check next
-mm, raise a patch against that.
