Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131216AbRAWSjB>; Tue, 23 Jan 2001 13:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131238AbRAWSiv>; Tue, 23 Jan 2001 13:38:51 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:22001 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S131216AbRAWSin>; Tue, 23 Jan 2001 13:38:43 -0500
Date: Tue, 23 Jan 2001 12:38:42 -0600
From: Timur Tabi <ttabi@interactivesi.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10101231903380.14027-100000@zeus.fh-brandenburg.de>
In-Reply-To: <3A6D5D28.C132D416@sangate.com>
Subject: Re: ioremap_nocache problem?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-Id: <20010123183847Z131216-18594+636@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Roman Zippel <zippel@fh-brandenburg.de> on Tue, 23 Jan
2001 19:12:36 +0100 (MET)


> ioremap creates a new mapping that shouldn't interfere with MTRR, whereas
> you can map a MTRR mapped area into userspace. But I'm not sure if it's
> correct that no flag is set for boot_cpu_data.x86 <= 3...

I was under the impression that the "don't cache" bit that ioremap_nocache sets
overrides any MTRR.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
