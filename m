Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316759AbSE3UoH>; Thu, 30 May 2002 16:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316773AbSE3UoG>; Thu, 30 May 2002 16:44:06 -0400
Received: from web13808.mail.yahoo.com ([216.136.175.18]:22289 "HELO
	web13808.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316759AbSE3UoG>; Thu, 30 May 2002 16:44:06 -0400
Message-ID: <20020530204406.55023.qmail@web13808.mail.yahoo.com>
Date: Thu, 30 May 2002 13:44:06 -0700 (PDT)
From: William Chow <lilbilchow@yahoo.com>
Subject: is pci_alloc_consistent() really consistent on a pentium?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If IA32 builds use the i386 version of
pci_alloc_consistent(), how is the memory provided by
this function really write-thru (on a pentium) since
it appears to only set up the default mapping
(PCD/PWT==0)? In contrast, pgprot_noncached() and
pci_mmap_page_range() explicitly set these bits on a
pentium (i.e. when boot_cpu_data.x86 > 3). Or am I
missing something?

Please CC me on the response.

- William Chow

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
