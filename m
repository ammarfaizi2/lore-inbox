Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267779AbUIPANp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267779AbUIPANp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 20:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUIOVdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:33:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:3762 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267474AbUIOVaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:30:17 -0400
Date: Wed, 15 Sep 2004 14:33:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] tune vmalloc size
Message-Id: <20040915143355.11ef40bf.akpm@osdl.org>
In-Reply-To: <20040915125356.GA11250@elte.hu>
References: <20040915125356.GA11250@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> +		if (c == ' ' && !memcmp(from, "vmalloc=", 8))
> +			__VMALLOC_RESERVE = memparse(from+8, &from);

u o akpm an update to kernel-parameters.txt, please.
