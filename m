Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAXRsi>; Wed, 24 Jan 2001 12:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbRAXRs2>; Wed, 24 Jan 2001 12:48:28 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:2557 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129401AbRAXRsV>; Wed, 24 Jan 2001 12:48:21 -0500
Date: Wed, 24 Jan 2001 11:48:19 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
        Linux MM mailing list <linux-mm@kvack.org>
Subject: Page Attribute Table (PAT) support?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-Id: <20010124174824Z129401-18594+948@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Page Attribute Table (PAT) is an extension to the x86 page table format
that lets you enable Write Combining on a per-page basis.  Details can be found
in chapter 9.13 of the Intel Architecture Software Developer's Manual, Volume 3
(System Programming).

I noticed that 2.4 doesn't support the Page Attribute Table, despite the fact
that it has a X86_FEATURE_PAT macro in processor.h.  Are there any plans to add
this support?  Ideally, I'd like it to be as a parameter for ioremap.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
