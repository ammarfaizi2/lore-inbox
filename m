Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWHTTv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWHTTv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 15:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWHTTv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 15:51:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35796 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751195AbWHTTv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 15:51:26 -0400
Subject: Re: [PATCH] introduce kernel_execve function to replace
	__KERNEL_SYSCALLS__
From: Arjan van de Ven <arjan@infradead.org>
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: Chase Venters <chase.venters@clientec.com>, Andrew Morton <akpm@osdl.org>,
       Arnd Bergmann <arnd@arndb.de>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-Reply-To: <20060820194552.GB11843@atjola.homenet>
References: <20060819073031.GA25711@atjola.homenet>
	 <200608201237.13194.chase.venters@clientec.com>
	 <20060820112523.f14fc6dc.akpm@osdl.org>
	 <200608201333.02951.chase.venters@clientec.com>
	 <20060820194552.GB11843@atjola.homenet>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 20 Aug 2006 21:50:46 +0200
Message-Id: <1156103446.23756.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

\
> Could we rename __syscall_return to IS_SYS_ERR (or whatever) and force
> kernel syscall users to do the check? That way we could eliminate errno

s/users/user/ .. there's one left that should die out soon ;)


