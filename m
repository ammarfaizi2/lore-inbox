Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWH2Jig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWH2Jig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWH2Jig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:38:36 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:65534 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964812AbWH2Jif convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:38:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/7] kill __KERNEL_SYSCALLS__
Date: Tue, 29 Aug 2006 11:37:43 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au
References: <20060827214734.252316000@klappe.arndb.de> <10191.1156842767@warthog.cambridge.redhat.com>
In-Reply-To: <10191.1156842767@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608291137.44649.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 11:12, David Howells wrote:
> > Ok, next try. This time a full series that tries to kill
> > off __KERNEL_SYSCALLS__, _syscallX() and the global errno
> > for good.
> 
> Have you checked uClibc?  Does that use _syscallX()?

uClibc has its own copy of these macros.

	Arnd <><
