Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUCLJaE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 04:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUCLJaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 04:30:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:20416 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262049AbUCLJaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 04:30:00 -0500
Date: Fri, 12 Mar 2004 01:29:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1: unknown symbols cauased by
 remove-more-KERNEL_SYSCALLS.patch
Message-Id: <20040312012942.5fd30052.akpm@osdl.org>
In-Reply-To: <200403121014.40889.arnd@arndb.de>
References: <20040310233140.3ce99610.akpm@osdl.org>
	<20040311203108.GE14833@fs.tum.de>
	<200403121014.40889.arnd@arndb.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:
>
>  On Thursday 11 March 2004 21:31, you wrote:
>  > This causes the following unknown symbols in modules on i386:
> 
>  Sorry, that could not work. This patch reverts my changes to loadable
>  device drivers. As Arjan van de Ven already noted, they have to
>  be converted to request_firmware() anyway.

I just did an EXPORT_SYMBOL_GPL of the three symbols and added a suitably
rude changelog.  Is that inadequate?

