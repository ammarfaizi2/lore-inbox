Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755824AbWKQT0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755824AbWKQT0Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755826AbWKQT0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:26:16 -0500
Received: from mail.impinj.com ([206.169.229.170]:5479 "EHLO earth.impinj.com")
	by vger.kernel.org with ESMTP id S1755824AbWKQT0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:26:15 -0500
Subject: Re: Patch to fixe Data Acess error in dup_fd
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: sharyath@in.ibm.com
Cc: Sergey Vlasov <vsu@altlinux.ru>, Zhao Yu Wang <wangzyu@cn.ibm.com>,
       Pavel Emelianov <xemul@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1163768910.12593.19.camel@legolas.in.ibm.com>
References: <1163151121.3539.15.camel@legolas.in.ibm.com>
	 <20061114181656.6328e51a.vsu@altlinux.ru>
	 <1163530154.4871.14.camel@impinj-lt-0046>
	 <20061114204236.GA10840@procyon.home>
	 <1163540156.5412.9.camel@impinj-lt-0046>
	 <1163576300.8208.14.camel@legolas.in.ibm.com>
	 <1163578540.4987.7.camel@localhost.localdomain>
	 <1163768910.12593.19.camel@legolas.in.ibm.com>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 11:26:11 -0800
Message-Id: <1163791571.3125.0.camel@impinj-lt-0046>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 18:38 +0530, Sharyathi Nagesh wrote:
>   I looked into a few memtests that were run in similar machine. There
> are a few slab corruption issues but not while running memtest and no
> other issues.
>   Seems difficult to replicate.

Bummer.

Bisection with vanilla (non-distro) kernels may be your best bet, then.
I have tried to replicate this issue in my spare time, but so far have
been unsuccessful.

-- Vadim Lobanov

