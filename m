Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbUCLKKT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 05:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUCLKKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 05:10:19 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:58854 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261612AbUCLKKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 05:10:14 -0500
Date: Fri, 12 Mar 2004 10:08:51 +0000
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Arnd Bergmann <arnd@arndb.de>, bunk@fs.tum.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1: unknown symbols cauased by remove-more-KERNEL_SYSCALLS.patch
Message-ID: <20040312100851.GA12892@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
	bunk@fs.tum.de, linux-kernel@vger.kernel.org
References: <20040310233140.3ce99610.akpm@osdl.org> <200403121014.40889.arnd@arndb.de> <20040312012942.5fd30052.akpm@osdl.org> <200403121035.02977.arnd@arndb.de> <20040312014809.4f2b280e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312014809.4f2b280e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 01:48:09AM -0800, Andrew Morton wrote:

 > > The symbols are already exported on alpha, arm, parisc, um and x86_64,
 > > but I'd rather not have them available to modules at all in order to
 > > prevent driver writers from (ab)using them after KERNEL_SYSCALLS have been
 > > eliminated.
 > 
 > But then the removal of KERNEL_SYSCALLS becomes hostage to those drivers,
 > and nobody is working on them.   It'll never happen.

The DVB folks claimed to be working on fixing this up a few weeks back,
still not seen any patches though.

		Dave

