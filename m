Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbUCLJnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 04:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUCLJnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 04:43:19 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:48099 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S262042AbUCLJnS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 04:43:18 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.4-mm1: unknown symbols cauased by remove-more-KERNEL_SYSCALLS.patch
Date: Fri, 12 Mar 2004 10:35:02 +0100
User-Agent: KMail/1.6.1
References: <20040310233140.3ce99610.akpm@osdl.org> <200403121014.40889.arnd@arndb.de> <20040312012942.5fd30052.akpm@osdl.org>
In-Reply-To: <20040312012942.5fd30052.akpm@osdl.org>
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403121035.02977.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 March 2004 10:29, you wrote:
> I just did an EXPORT_SYMBOL_GPL of the three symbols and added a suitably
> rude changelog.  Is that inadequate?

The symbols are already exported on alpha, arm, parisc, um and x86_64,
but I'd rather not have them available to modules at all in order to
prevent driver writers from (ab)using them after KERNEL_SYSCALLS have been
eliminated.

	Arnd <><
