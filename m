Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUIEVnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUIEVnF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 17:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUIEVnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 17:43:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:54446 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267250AbUIEVnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 17:43:03 -0400
Date: Sun, 5 Sep 2004 14:41:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brian Gerst <bgerst@quark.didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] explicity align tss->stack
Message-Id: <20040905144103.487afba6.akpm@osdl.org>
In-Reply-To: <4139C6E2.1050000@quark.didntduck.org>
References: <4139C6E2.1050000@quark.didntduck.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <bgerst@quark.didntduck.org> wrote:
>
> Use an alignment attribute on the stack member of struct tss_struct 
>  instead of padding.  Also mark the limit of the TSS segment.

The TSS code got a significant working-over recently.  Please take a look
at next -mm, see if this patch is still appropriate?
