Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWH3Vvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWH3Vvg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 17:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWH3Vvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 17:51:36 -0400
Received: from ozlabs.org ([203.10.76.45]:28069 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932134AbWH3Vve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 17:51:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17654.1898.640805.571107@cargo.ozlabs.ibm.com>
Date: Thu, 31 Aug 2006 07:47:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Andi Kleen <ak@suse.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/6] rename the provided execve functions to kernel_execve
In-Reply-To: <20060830125037.585774000@klappe.arndb.de>
References: <20060830124356.567568000@klappe.arndb.de>
	<20060830125037.585774000@klappe.arndb.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:

> Some architectures provide an execve function that does not
> set errno, but instead returns the result code directly.
> Rename these to kernel_execve to get the right semantics there.
> Moreover, there is no reasone for any of these architectures to
> still provide __KERNEL_SYSCALLS__ or _syscallN macros, so
> remove these right away.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Paul Mackerras <paulus@samba.org>
