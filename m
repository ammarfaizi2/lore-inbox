Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264090AbUEMLIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264090AbUEMLIF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 07:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbUEMLIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 07:08:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:36802 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264090AbUEMLID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 07:08:03 -0400
Date: Thu, 13 May 2004 04:07:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Fruhwirth Clemens <clemens-dated-1085310070.4b1f@endorphin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AES i586 optimized
Message-Id: <20040513040732.75c5999c.akpm@osdl.org>
In-Reply-To: <20040513110110.GA8491@ghanima.endorphin.org>
References: <20040513110110.GA8491@ghanima.endorphin.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens <clemens-dated-1085310070.4b1f@endorphin.org> wrote:
>
>  The following patch adds an i586 optimized implementation of AES aka
>  Rijndael. It's following an integration strategy similiar to recent
>  s390/z990 integration for DES/SHA1. aes-i586-glue.c, a glue layer for
>  CryptoAPI, and aes-i586-asm.S, the actual implementation, are added to
>  arch/i386/crypto, as well as a config section to crypto/Kconfig.

Some benchmark figures would be useful.  Cache-cold and cache-hot.

>  The code has been in use for half a year by myself and the loop-aes project
>  for the last - I think - 2 years. I consider the implementation
>  production-stable. Andrew, please consider applying.

James Morris <jmorris@redhat.com> is the crypto guy....
