Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUIIO5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUIIO5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUIIO5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:57:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:29642 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S265489AbUIIO5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 10:57:24 -0400
Subject: 10 New compile/sparse warnings (overnight build)
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1094741838.4142.6.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 09 Sep 2004 07:57:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary:
   New warnings = 10
   Fixed warnings = 2

New warnings:
-------------
net/ipv4/ipconfig.c:969:10: warning: undefined identifier 'i'
net/ipv4/ipconfig.c:969:10: warning: generating address of non-lvalue

net/ipv4/ipconfig.c:969:10: warning: undefined identifier 'i'
net/ipv4/ipconfig.c:969:10: warning: generating address of non-lvalue

net/ipv4/ipconfig.c:969:32: warning: undefined identifier 'i'

net/ipv4/ipconfig.c:969:39: warning: unknown expression (7 46)

net/ipv4/ipconfig.c:970:18: warning: unknown expression (7 46)

net/ipv4/ipconfig.c:970:31: warning: undefined identifier 'i'
net/ipv4/ipconfig.c:970:31: warning: generating address of non-lvalue
net/ipv4/ipconfig.c:970:31: warning: loading unknown expression

net/ipv4/ipconfig.c:970:31: warning: undefined identifier 'i'
net/ipv4/ipconfig.c:970:31: warning: generating address of non-lvalue
net/ipv4/ipconfig.c:970:31: warning: loading unknown expression

net/ipv4/ipconfig.c:970:31: warning: undefined identifier 'i'
net/ipv4/ipconfig.c:970:31: warning: generating address of non-lvalue
net/ipv4/ipconfig.c:970:31: warning: loading unknown expression

net/ipv4/ipconfig.c:971:16: warning: unknown expression (7 46)

net/ipv4/ipconfig.c:971:9: warning: undefined identifier 'i'


Fixed warnings:
---------------
fs/coda/file.c:298:14: warning: incorrect type in initializer
(incompatible argument 5 (different address spaces))
fs/coda/file.c:298:14:    expected int [usertype] ( *sendfile )( ... )
fs/coda/file.c:298:14:    got int [usertype] ( static [addressable]
[toplevel] *<noident> )( ... )

fs/coda/file.c:61:66: warning: incorrect type in argument 5 (different
address spaces)
fs/coda/file.c:61:66:    expected void *<noident>
fs/coda/file.c:61:66:    got void [noderef] *target<asn:1>



