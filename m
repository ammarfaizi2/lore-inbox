Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317568AbSGTXjI>; Sat, 20 Jul 2002 19:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317576AbSGTXjI>; Sat, 20 Jul 2002 19:39:08 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:48370 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317568AbSGTXjH>; Sat, 20 Jul 2002 19:39:07 -0400
Subject: Re: [PATCH] VM strict overcommit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: akpm@zip.com.au, Linus Torvalds <torvalds@transmeta.com>,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <1027196403.1086.751.camel@sinai>
References: <1027196403.1086.751.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 01:54:03 +0100
Message-Id: <1027212843.16818.59.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -urN linux-2.5.27/mm/mremap.c linux/mm/mremap.c
> --- linux-2.5.27/mm/mremap.c	Sat Jul 20 12:11:22 2002
> +++ linux/mm/mremap.c	Sat Jul 20 12:35:11 2002
> @@ -1,7 +1,10 @@
>  /*
> - *	linux/mm/remap.c
> + *	mm/remap.c
>   *
>   *	(C) Copyright 1996 Linus Torvalds
> + *
> + *	Address space accounting code	<alan@redhat.com>
> + *	(C) Copyright 2002 Red Hat Inc, All Rights Reserved

Second item, which may well not have been obvious from the original. The
change on the mm/*.c headers for the files changes to include the GPL
statement is part of my patch. The code submissions by Red Hat are GPL
and the no warranty clauses are applicable. When you resubmit them
please include the correct GPL headers I added, or a written guarantee
that you will personally take liability for all defects, errors and so
on. Also since you changed the code please credit yourself too.

The GPL no warranty clauses were added directly to the file because they
are suppsed to be there.


