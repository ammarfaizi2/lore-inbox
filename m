Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265337AbRGBRAU>; Mon, 2 Jul 2001 13:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265342AbRGBRAK>; Mon, 2 Jul 2001 13:00:10 -0400
Received: from imo-m04.mx.aol.com ([64.12.136.7]:43774 "EHLO
	imo-m04.mx.aol.com") by vger.kernel.org with ESMTP
	id <S265337AbRGBRAC>; Mon, 2 Jul 2001 13:00:02 -0400
Date: Mon, 02 Jul 2001 12:59:52 -0400
From: hunghochak@netscape.net (Ho Chak Hung)
To: linux-kernel@vger.kernel.org
Subject: __alloc_pages: 4-order allocation failed
Mime-Version: 1.0
Message-ID: <6586AA62.338A01A4.0F76C228@netscape.net>
X-Mailer: Franklin Webmailer 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the error __alloc_pages: 4-order allocation failed in a module that uses and frees a lot of pages.
Basically, I am trying implement a page cache for the module. First, I keep allocating pages using page_cache_alloc() until it fails, then I free a whole bunch of pages using freepages((unsigned long)page_address(page))

Would anyone please give me some advice about how to solve this problem?
Thanks a lot.

__________________________________________________________________
Get your own FREE, personal Netscape Webmail account today at http://webmail.netscape.com/
