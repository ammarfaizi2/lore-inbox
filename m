Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135662AbRAYSTW>; Thu, 25 Jan 2001 13:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135677AbRAYSTI>; Thu, 25 Jan 2001 13:19:08 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:15099 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S135717AbRAYSSr>; Thu, 25 Jan 2001 13:18:47 -0500
Date: Thu, 25 Jan 2001 12:18:43 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Jeff Hartmann <jhartmann@valinux.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <3A706CCF.8010400@valinux.com>
In-Reply-To: <3A6D5D28.C132D416@sangate.com> <20010123165117Z131182-221+34@kanga.kvack.org> 
	<20010123165117Z131182-221+34@kanga.kvack.org> ; from ttabi@interactivesi.com on Tue, Jan 23, 2001 at 10:53:51AM -0600 <20010125155345Z131181-221+38@kanga.kvack.org> 
	<20010125165001Z132264-460+11@vger.kernel.org> <E14LpvQ-0008Pw-00@mail.valinux.com> 
	<20010125175308Z130507-460+45@vger.kernel.org>
Subject: Re: ioremap_nocache problem?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Message-Id: <20010125181852Z135717-460+57@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Jeff Hartmann <jhartmann@valinux.com> on Thu, 25 Jan
2001 11:13:35 -0700


> You need to have your driver in the early bootup process then.  When 
> memory is being detected (but before the free lists are created.), you 
> can set your page as being reserved. 

But doesn't this mean that my driver has to be built as part of the kernel?
The end-user won't have the source code, so he won't be able to compile it, only
link it.  As it stands now, our driver is a binary that can be shipped
separately.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
