Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263584AbRFAQB1>; Fri, 1 Jun 2001 12:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263591AbRFAQBS>; Fri, 1 Jun 2001 12:01:18 -0400
Received: from [195.139.250.10] ([195.139.250.10]:23302 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S263574AbRFAQBK>;
	Fri, 1 Jun 2001 12:01:10 -0400
Message-ID: <3B17BBC5.6EE2A423@scali.no>
Date: Fri, 01 Jun 2001 17:59:01 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Question regarding pci_alloc_consitent() and __get_free_pages
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question regarding the pci_alloc_consistent() function. Will this function
allocate pages that are physical contiguous ? i.e if I call this function with a size
argument of 32KByte will that be 8 consecutive pages in memory on i386 architecture (4
pages on alpha). In general, will __get_free_pages(GFP_ATOMIC, order) always return
physical contiguous memory ?

All feedback appreciated,
-- 
  Steffen Persvold               Systems Engineer
  Email : mailto:sp@scali.no     Scali AS (http://www.scali.com)
  Tlf   : (+47) 22 62 89 50      Olaf Helsets vei 6
  Fax   : (+47) 22 62 89 51      N-0621 Oslo, Norway
