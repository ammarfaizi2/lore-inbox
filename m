Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWH3MyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWH3MyD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWH3Mxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:53:38 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:57031 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750929AbWH3Mxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:53:35 -0400
Message-Id: <20060830124356.567568000@klappe.arndb.de>
Date: Wed, 30 Aug 2006 14:43:56 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Andi Kleen <ak@suse.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 0/6] kill __KERNEL_SYSCALLS__, try #3
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should address all comments I got for the second version.
Since there is no common agreement on what should happen to
the _syscallX macros, I'm not touching them at all this time.

Whoever wants to remove, reenable or replace them, should send
a separate set of patches for these. With my patches, these
macros are not used in the kernel, and not useable from user
space, so we should probably do _something_ about them.

	Arnd <><

--

