Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWDCIee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWDCIee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 04:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWDCIee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 04:34:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51160 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750815AbWDCIed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 04:34:33 -0400
Date: Mon, 3 Apr 2006 01:33:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@sgi.com>
Cc: oleg@tv-sign.ru, ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.17-rc1] Reinstate const in next_thread()
Message-Id: <20060403013342.5e34c3ba.akpm@osdl.org>
In-Reply-To: <25335.1144052721@kao2.melbourne.sgi.com>
References: <25335.1144052721@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@sgi.com> wrote:
>
> Before commit 47e65328a7b1cdfc4e3102e50d60faf94ebba7d3, next_thread()
> took a const task_t.  Reinstate the const qualifier, getting the next
> thread never changes the current thread.
> 

Can do, but why?  Does code generation improve?

