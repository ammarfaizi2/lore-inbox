Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUGFJJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUGFJJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 05:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUGFJJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 05:09:45 -0400
Received: from ozlabs.org ([203.10.76.45]:61136 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263735AbUGFJJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 05:09:43 -0400
Subject: Re: 2.6.7-mm6 - ppc32 inconsistent kallsyms data
From: Rusty Russell <rusty@rustcorp.com.au>
To: Keith Owens <kaos@sgi.com>
Cc: Joseph Fannin <jhf@rivenstone.net>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org
In-Reply-To: <13859.1089099082@kao2.melbourne.sgi.com>
References: <13859.1089099082@kao2.melbourne.sgi.com>
Content-Type: text/plain
Message-Id: <1089104963.9417.4.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 06 Jul 2004 19:09:23 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-06 at 17:31, Keith Owens wrote:
> This is a real linker problem on ppc32.  The linker automatically adds
> _SDA_BASE_ and _SDA2_BASE_ symbols, these symbols are not defined in
> vmlinux.lds.S.

What type are those symbols?  I'm surprised they're not 'A' which is
already ignored...

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

