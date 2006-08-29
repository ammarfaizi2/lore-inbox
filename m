Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWH2RXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWH2RXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 13:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWH2RXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 13:23:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11968 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751107AbWH2RXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 13:23:36 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060827215637.781868000@klappe.arndb.de> 
References: <20060827215637.781868000@klappe.arndb.de>  <20060827214734.252316000@klappe.arndb.de> 
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au
Subject: Re: [PATCH 7/7] remove the global errno from the kernel 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 29 Aug 2006 18:23:18 +0100
Message-ID: <26089.1156872198@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> The last in-kernel user of errno is gone, so we should
> remove the definition and everything referring to it.
> This also removes the now-unused lib/execve.c file
> that was introduced earlier.

	  CC      lib/execve.o
	frv-linux-gnu-gcc: lib/execve.c: No such file or directory
	frv-linux-gnu-gcc: no input files

You perchance forgot to remove something added in patch 1/7.

David
