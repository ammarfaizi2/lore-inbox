Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUCOWEK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbUCOWD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:03:29 -0500
Received: from colino.net ([62.212.100.143]:38390 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262772AbUCOWDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:03:07 -0500
Date: Mon, 15 Mar 2004 23:02:20 +0100
From: Colin Leroy <colin@colino.net>
To: "David S. Miller" <davem@redhat.com>
Cc: Tom Rini <trini@kernel.crashing.org>, cieciwa@alpha.zarz.agh.edu.pl,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [SPARC64][PPC] strange error ..
Message-Id: <20040315230220.3f35fd48@jack.colino.net>
In-Reply-To: <20040315123953.3b6b863f.davem@redhat.com>
References: <Pine.LNX.4.58L.0403151437360.16193@alpha.zarz.agh.edu.pl>
	<Pine.LNX.4.58L.0403151939460.17732@alpha.zarz.agh.edu.pl>
	<20040315190026.GG4342@smtp.west.cox.net>
	<20040315123953.3b6b863f.davem@redhat.com>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__15_Mar_2004_23_02_20_+0100_x.NvyqNmytkv.Ngq"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Mon__15_Mar_2004_23_02_20_+0100_x.NvyqNmytkv.Ngq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 15 Mar 2004 at 12h03, David S. Miller wrote:

Hi, 

> I think the best fix is to include linux/linkage.h in asm/unistd.h as
> you seem to be suggesting, and therefore that is the change I will
> push off to Linus to fix this on sparc32 and sparc64.

My first patch did that :)
See '[PATCH] 2.6.4-bk3 ppc32 compile fix' thread. 
Re-attaching just in case.
-- 
Colin

--Multipart=_Mon__15_Mar_2004_23_02_20_+0100_x.NvyqNmytkv.Ngq
Content-Type: application/octet-stream;
 name="2.6.4-bk3.compile.fix"
Content-Disposition: attachment;
 filename="2.6.4-bk3.compile.fix"
Content-Transfer-Encoding: base64

LS0tIGluY2x1ZGUvYXNtLXBwYy91bmlzdGQuaC5vbGQJMjAwNC0wMy0xNCAyMjo1Njo0Mi45MDEx
MDU3ODQgKzAxMDAKKysrIGluY2x1ZGUvYXNtLXBwYy91bmlzdGQuaAkyMDA0LTAzLTE0IDIyOjU2
OjQ1LjI3Njc0NDYzMiArMDEwMApAQCAtMzgwLDYgKzM4MCw3IEBACiAKICNpbmNsdWRlIDxsaW51
eC9jb21waWxlci5oPgogI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+CisjaW5jbHVkZSA8bGludXgv
bGlua2FnZS5oPgogCiAvKgogICogU3lzdGVtIGNhbGwgcHJvdG90eXBlcy4K

--Multipart=_Mon__15_Mar_2004_23_02_20_+0100_x.NvyqNmytkv.Ngq--
