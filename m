Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbTFYGFS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 02:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbTFYGFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 02:05:18 -0400
Received: from dp.samba.org ([66.70.73.150]:55954 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262358AbTFYGFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 02:05:13 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Stewart Smith <stewart@linux.org.au>
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: remove --help-- and ---help--- entries from Kconfig files 
In-reply-to: Your message of "Tue, 24 Jun 2003 21:06:11 +1000."
             <20030624110611.GC8052@cancer> 
Date: Wed, 25 Jun 2003 16:10:37 +1000
Message-Id: <20030625061924.31AA42C250@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030624110611.GC8052@cancer> you write:
> It seems that the dashes prefixing/suffixing a lot of the help
> entries in Kconfig files have little or no meaning (i couldn't
> find any docs, and didn't see any difference to help messages
> after this patch)
> 
> This (rather long and reproducable by a command line < 100 chars)
> patch replaces all -*help-* entries with just help

IIRC they were explicitly added by Roman after people wanted more
visual delineation.

So I've not taken your patch, but you may want submit another that
adds this to the fine documentation in

     Documentation/kbuild/kconfig-language.txt

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
