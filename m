Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264426AbUDZFIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbUDZFIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 01:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264427AbUDZFIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 01:08:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:24796 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264426AbUDZFIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 01:08:54 -0400
Date: Sun, 25 Apr 2004 22:08:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix warning in prefetch_range
Message-Id: <20040425220837.315726d1.akpm@osdl.org>
In-Reply-To: <408AFD6C.9080100@quark.didntduck.org>
References: <408AFD6C.9080100@quark.didntduck.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <bgerst@didntduck.org> wrote:
>
> Fix this warning:
> include/linux/prefetch.h: In function `prefetch_range':
> include/linux/prefetch.h:62: warning: pointer of type `void *' used in 
> arithmetic
> 

eh?  That's a gcc extension which has worked silently since forever.

What compiler version is generating the warning?
