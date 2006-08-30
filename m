Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWH3MjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWH3MjV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWH3MjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:39:21 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:30689 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750805AbWH3MjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:39:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 4/7] Remove the use of _syscallX macros in UML
Date: Wed, 30 Aug 2006 14:38:41 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au
References: <20060827214734.252316000@klappe.arndb.de> <20060827215636.797086000@klappe.arndb.de> <44F524EE.90304@zytor.com>
In-Reply-To: <44F524EE.90304@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608301438.42079.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 07:41, H. Peter Anvin wrote:
> syscall() is a horrible botch; it is in fact unimplementable (without 
> enormous switch statements) on a number of architectures.
> 
Ok, good point. I'll leave the _syscallX() macros in for now and only
remove the kernel syscalls in my next submission, so we get at least
the non-controversial part done.

	Arnd <><
