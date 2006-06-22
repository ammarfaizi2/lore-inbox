Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbWFVLNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbWFVLNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWFVLNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:13:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161053AbWFVLNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:13:42 -0400
Date: Thu, 22 Jun 2006 04:13:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [patch] cleanup: kthread workqueue rename
Message-Id: <20060622041316.b290b19d.akpm@osdl.org>
In-Reply-To: <20060622082912.GA6334@localhost.localdomain>
References: <20060622082912.GA6334@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 16:29:12 +0800
Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:

> -static struct workqueue_struct *helper_wq;
> +static struct workqueue_struct *kthread_wq;

"helper" is better.  It's there to help kthread launching and that's all it
does.  So "helper" is a more specific identification.

