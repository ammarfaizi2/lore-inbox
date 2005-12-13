Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVLMAaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVLMAaP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 19:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVLMAaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 19:30:15 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:7895 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932281AbVLMAaN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 19:30:13 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Date: Tue, 13 Dec 2005 01:30:04 +0100
User-Agent: KMail/1.8.3
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
References: <dhowells1134431145@warthog.cambridge.redhat.com>
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512130130.05186.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag 13 Dezember 2005 00:45 schrieb David Howells:
>  (7) Provides a debugging config option CONFIG_DEBUG_MUTEX_OWNER by which
> the mutex owner can be tracked and by which over-upping can be detected.

I can't see how your code actually detects the over-upping, although it's 
fairly obvious how it would be done. Did you miss one patch for this?

	Arnd <><
