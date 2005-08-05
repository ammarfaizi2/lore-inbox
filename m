Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVHEXZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVHEXZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 19:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVHEXZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 19:25:56 -0400
Received: from lixom.net ([66.141.50.11]:1212 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S262028AbVHEXZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 19:25:55 -0400
Date: Fri, 5 Aug 2005 18:25:30 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Export handle_mm_fault to modules.
Message-ID: <20050805232530.GA8791@austin.ibm.com>
References: <1123278912.8224.2.camel@localhost.localdomain> <Pine.LNX.4.58.0508051558520.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508051558520.3258@g5.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 04:02:13PM -0700, Linus Torvalds wrote:

> The only thing that has ever exported it afaik is
> 
> 	arch/ppc/kernel/ppc_ksyms.c:EXPORT_SYMBOL(handle_mm_fault); /* For MOL */
> 
> and that looks pretty suspicious too (what is MOL, and regardless, 
> shouldn't it be an EXPORT_SYMBOL_GPL?).

Mac-on-Linux, see http://www.maconlinux.org/. Run MacOS in a virtualized
machine under Linux (or the other way around). It's GPL.


-Olof
