Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUCLJs1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 04:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUCLJs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 04:48:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:9421 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262060AbUCLJs0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 04:48:26 -0500
Date: Fri, 12 Mar 2004 01:48:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1: unknown symbols cauased by
 remove-more-KERNEL_SYSCALLS.patch
Message-Id: <20040312014809.4f2b280e.akpm@osdl.org>
In-Reply-To: <200403121035.02977.arnd@arndb.de>
References: <20040310233140.3ce99610.akpm@osdl.org>
	<200403121014.40889.arnd@arndb.de>
	<20040312012942.5fd30052.akpm@osdl.org>
	<200403121035.02977.arnd@arndb.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Friday 12 March 2004 10:29, you wrote:
> > I just did an EXPORT_SYMBOL_GPL of the three symbols and added a suitably
> > rude changelog.  Is that inadequate?
> 
> The symbols are already exported on alpha, arm, parisc, um and x86_64,
> but I'd rather not have them available to modules at all in order to
> prevent driver writers from (ab)using them after KERNEL_SYSCALLS have been
> eliminated.
> 

But then the removal of KERNEL_SYSCALLS becomes hostage to those drivers,
and nobody is working on them.   It'll never happen.

