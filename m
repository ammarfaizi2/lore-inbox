Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272222AbTHNFtU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 01:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272223AbTHNFtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 01:49:20 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:55248 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S272222AbTHNFtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 01:49:19 -0400
Date: Thu, 14 Aug 2003 08:45:53 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: insecure <insecure@mail.od.ua>
cc: Lars Duesing <ld@stud.fh-muenchen.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test3mm1 + gcc 3.2.3 | gcc3.3 compile error (Input/output
 error)
In-Reply-To: <200308132308.03220.insecure@mail.od.ua>
Message-ID: <Pine.LNX.4.56.0308140845040.31874@hosting.rdsbv.ro>
References: <Pine.LNX.4.56.0308121603010.8716@hosting.rdsbv.ro>
 <1060694115.22608.3.camel@ws1.intern.stud.fh-muenchen.de>
 <Pine.LNX.4.56.0308121621280.8716@hosting.rdsbv.ro> <200308132308.03220.insecure@mail.od.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have space on disk.
> > cat "arch/i386/kernel/built-in.o > /dev/null" works ok, without errors
> > (dmesg).
> >
> > Other ideas?
>
> strace ld invocation

I did. I get i/o error on read from drivers/built-in.o.
The problem is gone in 2.6.0test3.

Thanks!

> --
> vda
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro
