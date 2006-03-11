Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752272AbWCKAFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbWCKAFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 19:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbWCKAFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 19:05:37 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:26068 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1752271AbWCKAFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 19:05:37 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/1] x86: Make _syscallX() macros compile in PIC mode on i386
Date: Sat, 11 Mar 2006 01:05:20 +0100
User-Agent: KMail/1.9.1
Cc: Markus Gutschke <markus@google.com>, linux-kernel@vger.kernel.org,
       dkegel@google.com
References: <4410BB32.1020905@google.com> <4410EC8A.4020808@google.com> <20060309192232.2fd4767c.akpm@osdl.org>
In-Reply-To: <20060309192232.2fd4767c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603110105.21298.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Friday 10 March 2006 04:22 schrieb Andrew Morton:
> afaik, execve() is the only reason for retaining __KERNEL_SYSCALLS__
> support on x86.

Yes. Actually sh64 seems to be the only architecture left where
__KERNEL_SYSCALLS__ is used for something besides execve.

	Arnd <><
