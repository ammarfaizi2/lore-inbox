Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161377AbWALWmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161377AbWALWmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161380AbWALWmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:42:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30899 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161382AbWALWmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:42:16 -0500
Date: Thu, 12 Jan 2006 14:39:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [git patches] 2.6.x net driver updates
Message-Id: <20060112143938.5cf7d6a5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601121423120.3535@g5.osdl.org>
References: <20060112221322.GA25470@havoc.gtf.org>
	<Pine.LNX.4.64.0601121423120.3535@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> On Thu, 12 Jan 2006, Jeff Garzik wrote:
>  > 
>  > dann frazier:
>  >       CONFIG_AIRO needs CONFIG_CRYPTO
> 
>  I think this is done wrong.
> 
>  It should "select CRYPTO" rather than "depends on CRYPTO".
> 
>  Otherwise people won't see it just because they don't have crypto enabled, 
>  which is not very user-friendly.
> 

Yes, I think that's much more Aunt-Nellie-friendly, but Roman considers it
abuse of the Kconfig system in ways which I never completely understood?
