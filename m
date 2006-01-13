Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161505AbWAMJTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161505AbWAMJTQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 04:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161506AbWAMJTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 04:19:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19412 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161505AbWAMJTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 04:19:14 -0500
Date: Fri, 13 Jan 2006 01:18:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com,
       dhowells@redhat.com
Subject: Re: [PATCH] [5/6] Handle TIF_RESTORE_SIGMASK for i386
Message-Id: <20060113011848.577785f6.akpm@osdl.org>
In-Reply-To: <1137140937.2675.4.camel@localhost.localdomain>
References: <1136923488.3435.78.camel@localhost.localdomain>
	<1136924357.3435.107.camel@localhost.localdomain>
	<20060112195950.60188acf.akpm@osdl.org>
	<1137126606.3085.44.camel@localhost.localdomain>
	<20060112205451.392c0c5c.akpm@osdl.org>
	<20060112221037.5dbc3dd9.akpm@osdl.org>
	<1137133408.3621.6.camel@pmac.infradead.org>
	<1137140937.2675.4.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> -long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
>  +asmlinkage long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)

Fixed, thanks.
