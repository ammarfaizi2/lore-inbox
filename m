Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266308AbUIIQnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUIIQnr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUIIQnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:43:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:61158 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S266295AbUIIQjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:39:31 -0400
Subject: Re: 10 New compile/sparse warnings (overnight build)
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1094741838.4142.6.camel@cherrybomb.pdx.osdl.net>
References: <1094741838.4142.6.camel@cherrybomb.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1094747967.2468.35.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 09 Sep 2004 09:39:27 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about the duplicate entries.  I'll fix the tool.  There are really
just 7 new sparse warnings.

John

On Thu, 2004-09-09 at 07:57, John Cherry wrote:
> Summary:
>    New warnings = 10
>    Fixed warnings = 2
> 
> New warnings:
> -------------
> net/ipv4/ipconfig.c:969:10: warning: undefined identifier 'i'
> net/ipv4/ipconfig.c:969:10: warning: generating address of non-lvalue
> 
> net/ipv4/ipconfig.c:969:10: warning: undefined identifier 'i'
> net/ipv4/ipconfig.c:969:10: warning: generating address of non-lvalue
> 
> net/ipv4/ipconfig.c:969:32: warning: undefined identifier 'i'
> 
> net/ipv4/ipconfig.c:969:39: warning: unknown expression (7 46)
> 
> net/ipv4/ipconfig.c:970:18: warning: unknown expression (7 46)
> 
> net/ipv4/ipconfig.c:970:31: warning: undefined identifier 'i'
> net/ipv4/ipconfig.c:970:31: warning: generating address of non-lvalue
> net/ipv4/ipconfig.c:970:31: warning: loading unknown expression
> 
> net/ipv4/ipconfig.c:970:31: warning: undefined identifier 'i'
> net/ipv4/ipconfig.c:970:31: warning: generating address of non-lvalue
> net/ipv4/ipconfig.c:970:31: warning: loading unknown expression
> 
> net/ipv4/ipconfig.c:970:31: warning: undefined identifier 'i'
> net/ipv4/ipconfig.c:970:31: warning: generating address of non-lvalue
> net/ipv4/ipconfig.c:970:31: warning: loading unknown expression
> 
> net/ipv4/ipconfig.c:971:16: warning: unknown expression (7 46)
> 
> net/ipv4/ipconfig.c:971:9: warning: undefined identifier 'i'
> 
> 
> Fixed warnings:
> ---------------
> fs/coda/file.c:298:14: warning: incorrect type in initializer
> (incompatible argument 5 (different address spaces))
> fs/coda/file.c:298:14:    expected int [usertype] ( *sendfile )( ... )
> fs/coda/file.c:298:14:    got int [usertype] ( static [addressable]
> [toplevel] *<noident> )( ... )
> 
> fs/coda/file.c:61:66: warning: incorrect type in argument 5 (different
> address spaces)
> fs/coda/file.c:61:66:    expected void *<noident>
> fs/coda/file.c:61:66:    got void [noderef] *target<asn:1>
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

