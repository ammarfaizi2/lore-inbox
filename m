Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291550AbSBAFSn>; Fri, 1 Feb 2002 00:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291552AbSBAFSd>; Fri, 1 Feb 2002 00:18:33 -0500
Received: from zok.sgi.com ([204.94.215.101]:37098 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S291550AbSBAFST>;
	Fri, 1 Feb 2002 00:18:19 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
        vandrove@vc.cvut.cz, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
In-Reply-To: Your message of "Fri, 01 Feb 2002 00:12:42 CDT."
             <20020201001242.A25753@havoc.gtf.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Feb 2002 16:18:03 +1100
Message-ID: <26363.1012540683@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2002 00:12:42 -0500, 
Jeff Garzik <garzik@havoc.gtf.org> wrote:
>On Fri, Feb 01, 2002 at 04:10:13PM +1100, Keith Owens wrote:
>> Why can't I do it?  Linus wants the current method, where monolithic
>> Makefiles control initialization order.
>
>Wrong, we have multi-level initcalls now.

I know, it makes it even harder to see what the initialization order
is.  Some are controlled by the Makefile/subdirs order, some by special
calls in the code.

