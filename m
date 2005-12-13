Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbVLMVDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbVLMVDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbVLMVDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:03:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36017 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030219AbVLMVDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:03:49 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200512130130.05186.arnd@arndb.de> 
References: <200512130130.05186.arnd@arndb.de>  <dhowells1134431145@warthog.cambridge.redhat.com> 
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 13 Dec 2005 21:03:35 +0000
Message-ID: <27928.1134507815@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> I can't see how your code actually detects the over-upping, although it's 
> fairly obvious how it would be done. Did you miss one patch for this?

If owner is NULL, then you've probably upped twice.

David
