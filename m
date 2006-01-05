Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751899AbWAEDXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbWAEDXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 22:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWAEDXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 22:23:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750753AbWAEDXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 22:23:51 -0500
Date: Wed, 4 Jan 2006 19:23:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: jeff shia <tshxiayu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what is the state of current after an mm_fault occurs?
Message-Id: <20060104192334.1e88cfda.akpm@osdl.org>
In-Reply-To: <7cd5d4b40601041920u596551d2h75e167311e9452e4@mail.gmail.com>
References: <7cd5d4b40601040240n79b2d654t33424e91059988a9@mail.gmail.com>
	<20060104174808.7b882af8.akpm@osdl.org>
	<7cd5d4b40601041920u596551d2h75e167311e9452e4@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeff shia <tshxiayu@gmail.com> wrote:
>
> en,

Please see http://www.zip.com.au/~akpm/linux/patches/stuff/top-posting.txt

>  You mean in some pagefault place we do schedule()?

We used to - that should no longer be the case.  The TASK_RUNNING thing is
probably redundant now.

