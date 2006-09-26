Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWIZFOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWIZFOZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWIZFOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:14:24 -0400
Received: from ozlabs.org ([203.10.76.45]:7321 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751052AbWIZFOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:14:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17688.46820.516756.495462@cargo.ozlabs.ibm.com>
Date: Tue, 26 Sep 2006 15:13:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel Walker <dwalker@mvista.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] console: console_drivers not initialized
In-Reply-To: <20060925144204.e71c2423.akpm@osdl.org>
References: <20060925210710.931336000@mvista.com>
	<20060925211122.GC25257@flint.arm.linux.org.uk>
	<1159219581.3648.10.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	<20060925144204.e71c2423.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> What Russell said.  If the arch startup code isn't correctly zeroing bss
> then that's pretty badly busted.

Indeed.  We do actually zero the BSS on startup. :)

Paul.
