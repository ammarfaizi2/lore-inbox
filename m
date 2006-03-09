Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932653AbWCIMUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbWCIMUL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbWCIMUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:20:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63697 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932513AbWCIMUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:20:08 -0500
Date: Thu, 9 Mar 2006 04:18:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm3
Message-Id: <20060309041809.028c8c6a.akpm@osdl.org>
In-Reply-To: <44101B83.9060503@imap.cc>
References: <5NHCi-8jp-5@gated-at.bofh.it>
	<44101B83.9060503@imap.cc>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tilman Schmidt <tilman@imap.cc> wrote:
>
> Andrew Morton wrote:
> 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/
> 
>  This panics and dies during early boot with a divide error in kmem_cache_init
>  on my Dell GX110.

Yup, please apply ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/hot-fixes/revert-x86_64-mm-i386-early-alignment.patch
